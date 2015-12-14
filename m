From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] spi: dts: sun4i: Add support for
 hardware-based wait time between words
Date: Mon, 14 Dec 2015 08:31:55 +0100
Message-ID: <CAGNoLaOckrgv5NP6eTOt8shj5f069DKFrxx+8afydqcAZH5HMw@mail.gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
	<1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
	<20151214012937.GA12209@rob-hp-laptop>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRB3HAXGZQKGQEWOOWYSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151214012937.GA12209@rob-hp-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi,

2015-12-14 2:29 GMT+01:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Mon, Dec 14, 2015 at 12:04:11AM +0100, Marcus Weseloh wrote:
>> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
[...]
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index bbaa857..2d6034f 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -61,6 +61,8 @@ contain the following properties.
>>                        used for MOSI. Defaults to 1 if not present.
>>  - spi-rx-bus-width - (optional) The bus width(number of data wires) that
>>                        used for MISO. Defaults to 1 if not present.
>> +- spi-word-wait-ns - (optional) Hardware based delay between transmission of
>> +                      words in nanoseconds
>
> Could be a software delay if the h/w doesn't support delays.

Of course, I was still trapped in my sun4i specific thinking. Will
remove the hardware reference.

[...]
>> +     /* Setup wait time between words */
>> +     of_property_read_u32(spi->dev.of_node, "spi-word-wait-ns",
>> +                          &wait_ns);
>
> Read this in probe and save the value rather than fetching every
> transfer.

But this is a slave property I'm using here. If I read and store it in
probe in the spi-sun4i driver, I won't have access to the slave node
property, will I?

Cheers,

    Marcus
