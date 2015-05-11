From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: Add slave dma support
Date: Mon, 11 May 2015 07:11:43 +0200
Message-ID: <61BE0C45-D46F-4A2E-9B78-E38069398810@martin.sperl.org>
References: <1429355160-13657-1-git-send-email-noralf@tronnes.org> <DC1D0474-515B-4863-85FB-9E60FFA34829@martin.sperl.org> <554A69D5.90301@tronnes.org> <554C9BE0.60205@raspberrypi.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jonathan Bell <jonathan-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554C9BE0.60205-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 08.05.2015, at 13:20, Jonathan Bell <jonathan-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org> wro=
te:
>>=20
> I agree that the interrupt generated would be spurious - in the case =
where it is not required.
>=20
> However if you do && (flags & DMA_PREP_INTERRUPT) then all users of t=
his driver need to explicitly set interrupt flags when doing a scatter-=
gather transfer. As I understand it, currently the only upstream client=
 of this driver is the I2S driver which only uses cyclic anyway.
>=20
> Not requiring an interrupt on completion is a bit of an edge case - t=
he default among other dmaengine drivers appears to be to enable interr=
upts unconditionally.

I have now submitted a patch for spi-bcm2835 to make use of dma,
so there is one candidate for this kind of behavior.
So please go forward with the merge.

Also note that with the spi-HW dma support of the bcm2835
it is necessary to do a RX transfer even if the data is not
used (similar for TX).

Right now we have to allocate a dummy buffer to run these kind
of =E2=80=9Cone-way=E2=80=9D transfers where we need 2 DMA channels.

The bcm2835 dma hw supports such dummy-transfer modes via=20
BCM2835_DMA_S_IGNORE and BCM2835_DMA_D_IGNORE.

So maybe we can add a =E2=80=9Cflag=E2=80=9D to the dmaengine_prep_slav=
e_sg
that will allow such kind of behavior to get implemented?

That is not a necessity, but would be a welcome improvement.

Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
