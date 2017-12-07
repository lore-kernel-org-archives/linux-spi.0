From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM64: dts: meson-axg: add the SPICC controller
Date: Wed, 6 Dec 2017 16:04:04 -0800
Message-ID: <CAOi56cU0gQfCViSF=6o3uYKYaVi_Lwqwjiv_-Z6p1FFCPP1PMA@mail.gmail.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com> <20171128132926.19051-4-yixun.lan@amlogic.com>
 <7hy3mfmmtd.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
        Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        linux-amlogic <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hy3mfmmtd.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 6, 2017 at 3:57 PM, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org> writes:
>
>> From: Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>>
>> Add DT info for the SPICC controller which found in
>> the Amlogic's Meson-AXG SoC.
>>
>> Signed-off-by: Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>
> This patch looks OK but it doesn't apply cleanly.
>
> A quick glance suggests that it's becuase it has a dependency on the PWM
> series, but that dependency was not described here (or in the cover
> letter.)
>
> If the series does not apply directly on mainline, the cover letter
> should describe the dependencies clearly.
>
> In your case, I understand it's difficult because you have many series
> in parallel at the same time.  I would suggest that locally, you keep
> each series as independent branches based on the latest -rc tag.

Correction: while in general it's best to keep things based on the
latest -rc tag, for DT patches, it's even better if you base things on
my current <version>/dt64 branch (currently v4.16/dt64)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
