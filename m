From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] spi: dts: sun4i: Add support for wait
 time between word transmissions
Date: Thu, 17 Dec 2015 12:22:49 +0100
Message-ID: <CAGNoLaN=HJ-OR6oFiGWC58DG+w1A9qeEVyGBRb1vdf9BRNW=Rg@mail.gmail.com>
References: <1450080676-6704-1-git-send-email-mweseloh42@gmail.com>
	<20151216103927.GS19456@lukather>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRBCNWZKZQKGQEF5Y3K7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151216103927.GS19456@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Maxime,

2015-12-16 11:39 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> It looks mostly fine, however, please try to make only one thing in
> one patch.
>
> In this case, it would mean having one patch to add the DT property
> and support in the SPI core in a first one, and then add support for
> it in your driver.

Will do.

> I also have a minor comment below....
[...]
>> +     if (spi->word_wait_ns) {
>> +             clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
>> +             wait_clk = DIV_ROUND_UP(spi->word_wait_ns, clk_ns) - 3;
>> +             if (wait_clk < 1) {
>> +                     wait_clk = 1;
>> +                     dev_info(&spi->dev,
>> +                              "using minimum of 4 word wait cycles (%uns)",
>> +                              4 * clk_ns);
>
> Logging it at the info loglevel seems a bit too high. debug seems more
> appropriate.

I will change it to debug and send a new version.

Thanks for the review!

Marcus
