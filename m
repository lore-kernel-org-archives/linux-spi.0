From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: Add slave dma support
Date: Sat, 16 May 2015 19:31:36 +0200
Message-ID: <8352B3C1-D66A-4875-B38C-6C4593418E10@martin.sperl.org>
References: <1429355160-13657-1-git-send-email-noralf@tronnes.org> <5552231A.9010503@tronnes.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	jonathan-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5552231A.9010503-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 12.05.2015, at 17:58, Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wro=
te:
>=20
> Is there something missing for this patch to get accepted?
> spi-bcm2835 has now DMA support that depends on this patch.

As the spi-bcm2835.c patch using DMA (relying on this) has gone into
spi/for-next (but so far without the DT changes to enable DMA mode)
can we also get this dmaengine patch merged into for-next?

Note that I played BigBuckBunny movie on my spi TFT for the last
24 hours using DMA only and it works without any hickups using
the V2 patch provided by Noralf - it transferred 24GB so far.
I also did test it with spi-mmc and enc28j60 - all of which use DMA
with different access pattern, so that test should be quite
comprehensive.

Thanks,
	Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
