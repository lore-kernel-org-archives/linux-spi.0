From: Daniel Sobe <daniel.sobe-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] (re-send) spi-imx: improve timing of bursts
Date: Mon, 18 Aug 2014 07:31:56 +0000
Message-ID: <1408347115788.20072@nxp.com>
References: <b6c440a488274f0b89a8bb4047d8ee3b@AMSPR04MB517.eurprd04.prod.outlook.com>,<20140816151336.GA5813@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140816151336.GA5813-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

thanks for your reply and your comments. I will make sure to follow you=
r suggestions next time I try to submit a patch to the mailing list. It=
 doesn't make sense to try again with this patch, because the project i=
n which context it was created is already closed.

Regards,

Daniel

Daniel Sobe
Engineer, BL Car
NXP Semiconductors Germany GmbH

Am Waldschl=F6sschen 1, Dresden, Germany
Tel: +49 351 32023 504
E-Mail: daniel.sobe-3arQi8VN3Tc@public.gmane.org, www.nxp.com
Gesch=E4ftsf=FChrung: Ruediger Stroh (Vors.), Frans Scheper, Kurt Sieve=
rs, Erik Just-Wartiainen / Aufsichtsratsvorsitzender: Gernot Fiedler / =
Sitz: Hamburg / Registergericht: Hamburg HRB 84 865

The information contained in this message is confidential and may be le=
gally privileged. The message is intended solely for the addressee(s). =
If you are not the intended recipient, you are hereby notified that any=
 use, dissemination, or reproduction is strictly prohibited and may be =
unlawful. If you are not the intended recipient, please contact the sen=
der by return e-mail and destroy all copies of the original message.

Unless otherwise recorded in a written agreement, all sales transaction=
s by NXP Semiconductors are subject to our general terms and conditions=
 of commercial sale. These are published at: www.nxp.com/profile/terms/=
index.html

________________________________________
=46rom: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sent: Saturday, August 16, 2014 5:13 PM
To: Daniel Sobe
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] (re-send) spi-imx: improve timing of bursts

On Fri, Mar 28, 2014 at 11:05:49AM +0000, Daniel Sobe wrote:
>
> Hi,
>
> The patch below addresses 2 improvements:

Please follow the patch submission process covered in SubmittingPatches
- in particular you need to send patches to the relevant developers as
well as the mailing lists, you need to format your changelogs in the
standard Linux style (including word wrapping within paragraphs) and yo=
u
need to follow the kernel coding style.

If you only send your patch to the list there's a good chance it'll be
missed.

> 1) Burstsize of a transfer adjusted up to the maximum burstsize of th=
e  hardware --> no unwanted CS toggling between data words
> 2) Variable trigger level allows to increase priority for data transf=
er,  enables continuous transfers up to the burstsize. --> remove gaps =
 every 64 words

> The original behaviour of the driver is untouched. The additional fea=
tures can be enabled via sysfs.

Why would you ever want /CS toggling between words - such behaviour is
just plain buggy?

> +// (sysfs-)tunable attributes
> +static int allow_big_bursts =3D 0; // if set to 1 this enables 32-bi=
t big bursts
> +static int tx_fifo_thres =3D -1;   // if positive, use TX data reque=
st interrupt when applicable

These would need to be per device rather than global.  It's also not
clear to me that we don't want to enable some level of FIFO threashold
usage by default, perhaps aiming for something just slightly below the
full FIFO so that we minimise the number of extra interrupts but
increase throughput on lightly loaded systems - I'm not even sure that
making this behaviour tunable is needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
