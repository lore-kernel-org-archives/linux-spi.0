From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
Date: Mon, 11 Aug 2014 13:40:14 +0200
Message-ID: <20140811114014.GH15297@lukather>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
 <20140805200042.GO3952@lukather>
 <53E3D56C.5030204@elopez.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53E3D56C.5030204-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2014 at 04:37:16PM -0300, Emilio L=F3pez wrote:
> Hi,
>=20
> El 05/08/14 a las 17:00, Maxime Ripard escibi=F3:
> >Hi,
> >
> >Overall it looks very nice, thanks.
> >
> >On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L=F3pez wrote:
> >>+static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev=
 *priv,
> >>+                                                 struct sun4i_dma_vcha=
n *vchan)
> >>+{
> >>+       struct sun4i_dma_pchan *pchan =3D NULL, *pchans =3D priv->pchan=
s;
> >>+       unsigned long flags;
> >>+       int i, max;
> >>+
> >>+       /*
> >>+        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
> >>+        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
> >>+        */
> >>+       if (vchan->is_dedicated) {
> >>+               i =3D NDMA_NR_MAX_CHANNELS;
> >>+               max =3D DMA_NR_MAX_CHANNELS;
> >>+       } else {
> >>+               i =3D 0;
> >>+               max =3D NDMA_NR_MAX_CHANNELS;
> >>+       }
> >>+
> >>+       spin_lock_irqsave(&priv->lock, flags);
> >>+       for_each_clear_bit_from(i, &priv->pchans_used, max) {
> >>+               pchan =3D &pchans[i];
> >>+               pchan->vchan =3D vchan;
> >>+               set_bit(i, priv->pchans_used);
> >>+               break;
> >
> >ffz instead?
>=20
> I think it'd look way more messy with ffz, as it only works on
> unsigned longs and it's undefined on the all-1s case.
>=20
> We could have something like this, but I don't see much point in
> what's basically expanding the macro
>=20
> 	spin_lock_irqsave(&priv->lock, flags);
> 	i =3D find_next_zero_bit(&priv->pchans_used, max, i);
> 	if (i < max) {
> 		pchan =3D &pchans[i];
> 		pchan->vchan =3D vchan;
> 		set_bit(i, priv->pchans_used);
> 	}
> 	spin_unlock_irqrestore(&priv->lock, flags);

What about=20

spin_lock_irqsave(&priv->lock, flags);
i =3D ffz(&priv->pchans_used);
if (!i)
   return NULL;

pchan =3D &pchans[i];
pchan->vchan =3D vchan;
set_bit(i, priv->pchans_used);

spin_unlock_irqrestore(&priv->lock, flags);

It looks quite clean to me.

> >>+static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
> >>+{
> >>+	struct sun4i_dma_dev *priv =3D dev_id;
> >>+	struct sun4i_dma_vchan *vchan;
> >>+	unsigned long flags;
> >>+	int i;
> >>+
> >>+	for (i =3D 0; i < DMA_NR_MAX_VCHANS; i++) {
> >>+		vchan =3D &priv->vchans[i];
> >>+		spin_lock_irqsave(&vchan->vc.lock, flags);
> >>+		execute_vchan_pending(priv, vchan);
> >>+		spin_unlock_irqrestore(&vchan->vc.lock, flags);
> >>+	}
> >>+
> >>+	return IRQ_HANDLED;
> >>+}
> >
> >Judging from Russell's comment here, that should be in the interrupt
> >handler
> >
> >http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277737=
=2Ehtml
>=20
> Wouldn't that make the interrupt handler quite big time wise? I was
> under the impression they should remain as short as possible. LDD3
> says "The programmer should be careful to write a routine that
> executes in a minimum amount of time (...)" on chapter 10

Yeah, but if that involves delaying a lot a task that should have been
performed asap, it would make sense.

Plus, besides the loop in the contract's demands,
execute_vchan_pending is actually rather small. Did you timed it to
have such concerns?

> I did try something mid-way a bit ago; I added code to see if we
> could issue the next DMA operation from the current set, but it was
> just extra complexity for a noop in performance, as they're sets of
> one on all cases I tried.
>=20
> It's worth noting that the very latency sensitive DMA users we will
> have (ie, audio) are already completely managed in the IRQ handler
> thanks to the less flexible concept of cyclic transfers.

It's not just a matter of latency, but also of throughput. If you wait
for the tasklet softirq to be executed to schedule a new vchan, you
aren't going to do anything during that time, while you could have.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT6KueAAoJEBx+YmzsjxAgdncP/AlQUw/3nPf0Rmef3NU0/ylt
HlsIyahTT46CgBsvnqx4DlGW/+GhvmizRoQ520aP7RIYrLATN+CvG+xAfsXk1J/M
d5b8++C7KAw+6ucu9fxhr7ol8DZH7ObIDL5ugAHAOlqVqFkeaTQjM2J/bulP/4RK
jssPDkas6e1hYkM8XF08PcwHOuGJi0dyUqRr6FdLaMTPDxnljqqVrzYvXIF0E2nB
pMohMdQXNK6CAaO1Rws3mElClrnCdoqz/ZrNZEBLzUwxY6orKsVuLeWxEuVLAsh9
yhgoCmUhmbaL9fustpGIrD1en65si7tdhJ7GauPCVNWN/UlbqDUqnI30sS4eXqAI
UMS3coueUq9lYEXi0HaiD95j4A+geyGA+suqRquCmXl5UMHEE1NPMKsGbt4hOcW3
fEBJwtMidf2hi3mi3qv1EJdtTYfAFEEw8VMInOABUOnoeoeFiBMCa3fWCpDtNaVi
QMNYs6zVU9iwiCZnbhcAs6bCm1ThJHmEj6WEHjHPTf/2QC0rEAS+XWF/ZVfCPeNP
16piIIZkI+zmn5HQRMBMy/FjVciTHViiFFVEIcUCKpUvSuaM0xkNcbLqJNiASEgw
b+QeqEkA3n3u5fsZ7VKcK6/suh8ldTi27Fh6+QqgrWs4bIOOOJW6JJenuQ5Ao0A3
k07vuO/92Y/QLe9hO67G
=lZiZ
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
