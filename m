From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Fix cs_change inversion
Date: Mon, 16 Mar 2020 15:36:50 +0100
Message-ID: <20200316143650.GB19141@qmqm.qmqm.pl>
References: <1ca2cf159f77a49acfd787f856d44a2aae8d24fb.1584291526.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1ca2cf159f77a49acfd787f856d44a2aae8d24fb.1584291526.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Mar 15, 2020 at 06:06:51PM +0100, Micha³ Miros³aw wrote:
> cs_change for a transfer means to affect the chipselect line. The driver
> inverts the meaning of it for last transfer. Fix by correcting keep_cs
> values.
[...]

Please disregard this patch. As Mark Brown pointed out, this inversion of
meaning is actually intended.

Best Regards
Micha³ Miros³aw
