From: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Sun, 14 Feb 2016 15:28:30 +0900
Message-ID: <56C01E8E.6090107@gmail.com>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
 <20160209161036.GI13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160209161036.GI13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark.
Thank you for your review.
Please ignore previous mail that I sent to you.
I sent this mail without CC-ing. I resend including CC list.

On 2016=EB=85=84 02=EC=9B=94 10=EC=9D=BC 01:10, Mark Brown wrote:
> On Wed, Feb 10, 2016 at 12:26:25AM +0900, Youngmin Nam wrote:
>=20
>> SPI driver on some SoCs only differ in the fifosize of each
>> SPI channel. It is useless to duplicate the s3c64xx_spi_port_config =
structure
>> or create a compatible name for such a change.
>=20
> I disagree that it is useless to do this, it means that if we realize
> later that there is some other difference between the implementations
> then we have the information in the DT to handle this without needing=
=20
> to update the ABI.
>=20

To clarify, let me check that I understood.
Do you mean we can fix fifosize of each SPI channel with DT handling
if there is difference on this fifosize with driver code?

If I understand your words correctly, let me modify commit messages.=20

>> +Optional SoC Specific properties:
>> +
>> +- samsung,spi-fifosize: The fifo size supported by the SPI channel
>> +
>> +
>=20
> In units of...?  FIFO sizes do get quoted in both words and bytes so =
it
> seems good to be clear.
>=20

"samsung,spi-fifosize =3D <64>" means 64 bytes of fifosize.
Let me add the units as bytes.

Thank you.=20
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
