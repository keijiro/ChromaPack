using UnityEngine;
using UnityEditor;
using System.Collections;

class ChromaPackProcessor : AssetPostprocessor
{
    static float RGB_Y(Color rgb)
    {
        return 0.299f * rgb.r + 0.587f * rgb.g + 0.114f * rgb.b;
    }

    static float RGB_Cb(Color rgb)
    {
        return -0.168736f * rgb.r -0.331264f * rgb.g + 0.5f * rgb.b;
    }

    static float RGB_Cr(Color rgb)
    {
        return 0.5f * rgb.r - 0.418688f * rgb.g - 0.081312f * rgb.b;
    }

    static float RGB_Ya(Color rgb)
    {
        if (rgb.a < 0.5f)
            return 0;
        else
            return RGB_Y(rgb) * 255 / 256 + 1.0f / 256;
    }

    void OnPreprocessTexture()
    {
        var importer = assetImporter as TextureImporter;

        if (!assetPath.EndsWith("CP.png")) return;

        importer.textureType = TextureImporterType.GUI;
        importer.textureFormat = TextureImporterFormat.RGBA32;
    }

    void OnPostprocessTexture(Texture2D texture)
    {
        var importer = assetImporter as TextureImporter;

        if (!assetPath.EndsWith("CP.png")) return;

        var hasAlpha = importer.DoesSourceTextureHaveAlpha();

        var tw = texture.width;
        var th = texture.height;
        var source = texture.GetPixels();

        texture.Resize(tw * 3 / 2, th, TextureFormat.Alpha8, false);

        var pixels = texture.GetPixels();

        var i1 = 0;
        var i2 = 0;

        if (hasAlpha)
        {
            for (var iy = 0; iy < th; iy++)
            {
                for (var ix = 0; ix < tw; ix++)
                {
                    pixels[i2++].a = RGB_Ya(source[i1++]);
                }
                i2 += tw / 2;
            }
        }
        else
        {
            for (var iy = 0; iy < th; iy++)
            {
                for (var ix = 0; ix < tw; ix++)
                {
                    pixels[i2++].a = RGB_Y(source[i1++]);
                }
                i2 += tw / 2;
            }
        }

        i1 = 0;
        i2 = tw;
        var i3 = (tw * 3 / 2) * th / 2 + tw;

        for (var iy = 0; iy < th / 2; iy++)
        {
            for (var ix = 0; ix < tw / 2; ix++)
            {
                var ws = (source[i1] + source[i1 + 1] + source[i1 + tw] + source[i1 + tw + 1]) / 4;
                pixels[i2++].a = RGB_Cr(ws) + 0.5f;
                pixels[i3++].a = RGB_Cb(ws) + 0.5f;
                i1 += 2;
            }
            i1 += tw;
            i2 += tw;
            i3 += tw;
        }

        texture.SetPixels(pixels);
    }
}
