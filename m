From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH v2 1/7] spi: spi-ep93xx: remove io wrappers
Date: Tue, 8 Aug 2017 20:43:48 +0000
Message-ID: <284dbb1bcf3043caa5da5019f0cc4914@svr-chch-ex1.atlnz.lc>
References: <20170804000023.15624-1-chris.packham@alliedtelesis.co.nz>
 <20170804000023.15624-2-chris.packham@alliedtelesis.co.nz>
 <20170808094236.l5dnyrlh4sqybaqg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org" <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/08/17 21:42, Mark Brown wrote:=0A=
> On Fri, Aug 04, 2017 at 12:00:17PM +1200, Chris Packham wrote:=0A=
>> From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>=0A=
>>=0A=
>> The io wrappers just add obfuscation to the driver. Remove them.=0A=
>>=0A=
>> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>=0A=
>> ---=0A=
> =0A=
> I can't do anything with this patch since you haven't provided a signoff=
=0A=
> - this is essential for anything going upstream, please see=0A=
> SubmittingPatches for detais on what it means and why it's important.=0A=
> =0A=
=0A=
I didn't sign it because it's the patch that came from Hartley verbatim =0A=
(same for 5/7, 6/7 and 7/7). The ones I did sign I'd made changes to. =0A=
Re-reading the DCO point c I understand now that I should have signed =0A=
all of them so I'll submit a v3 series to do so.=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
