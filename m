From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
Date: Wed, 09 Sep 2015 11:27:24 -0700
Message-ID: <878u8fcusz.fsf@eliezer.anholt.net>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org> <87h9n4weg8.fsf@eliezer.anholt.net> <2757852.TDqE8OEVr2@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2757852.TDqE8OEVr2@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org> writes:

> Hi,
> On Tuesday 08 September 2015 18:48:07, Eric Anholt wrote:
>> I finally had a chance to sit down and look at what the hardware's doing
>> with the enable bit (also, I've read a whole lot more of the hardware
>> now, so I'm a lot faster at answering questions like this).  The enable
>> bits are a clock gate off of the VPU clock.
>
> Are any hardware documents about such things available (in public)?

Nope, I just went through the HDL to see how things were routed.

>> I knocked together the enable bits as a clock gate driver, since I'd
>> just written very similar code for the audio domain clock driver (and I
>> assume you are grumpy about how much time you've spent on this one
>> stupid register).  It's up at
>> https://github.com/anholt/linux/tree/bcm2835-clock-aux and I can submit
>> it if you like the result.  I've compile tested it only, but I'm hoping
>> you could just drop your aux SPI driver on top of it and have things
>> work.
>
> IMHO line 45 (https://github.com/anholt/linux/commit/facb4ba917a1b9f6c2ee0cea7d529acf55f584dd#diff-1b6f753c132811b3f6d70f5b31866950R45) should be like this
>> onecell->clks = kzalloc(sizeof(*onecell->clks) * BCM2835_AUX_CLOCK_COUNT, GFP_KERNEL);
> or you will only allocate a single struct clk*.

Thanks, that was a bug in my other clock driver, too!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV8HoMAAoJELXWKTbR/J7o2xEP/3R/27Yktr7ibuVDVEo/GE7z
5Zio4/u9EX9yE4FTj6g3UrroTAFHvKzxNZjd8EbgCnTYfuIuYA+Aa0+S/pEUWKf7
8WXNvL4LIbuHB2XfdGf//Gf4LD3he+/0YFMlnVAqK3A/jAMUDn4ptbZqloNgwnK1
YmgTN34dzWpS/D4TH1ScOJlJNaZc9ta9C8fX0T2AiOYCj0BsLiv9Rb37aR6/ZP8C
BHfk7zr1jmr/0NTY9d6locWS+xk/BxEbBMnhDCIthYZ6n8/Cjb+91vtntNRDIQJA
4ndBQ0j6p99HlROA37Y1a8Qp8GAiW7Xjrcyu8YQo6nq9w0LpUtPJjPuUIjAUMPNX
4a1mES+QrumvPjt9FQ+HmAa6+7ucep3crsvDBro+JzGfINU3GwNF4b++tP1VcwuU
UDqrUfcxpdBCn9YeHYowycHMNOJtAM/r1THcK6e/KJFL7haMIJvDWOmFK9HQP4c9
M457lQwpbpUy1/ncbV7j3gF2tSAizTnGval8sStcSJztjRnn7wwEIbC/Lcy4KpBI
B3gmy/wF9eabmxmevw4DQ8V9k04nAB8ykrThFhDSLcYyZUOWx4R6wi8i7tW05a4v
2tlVZrnz3XxjGAbVk4CiDvY+qMWmRaEW2lOb1Q/UuQUMB4gzvWyUaMaYr8g/Vh1O
hzNIyMd6Sx+1KDMWTci0
=CBKP
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
