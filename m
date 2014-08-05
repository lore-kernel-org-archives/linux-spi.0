From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
Date: Tue, 5 Aug 2014 22:00:42 +0200
Message-ID: <20140805200042.GO3952@lukather>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPdL5sOQ4GFWV+a5"
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407183002-29420-2-git-send-email-emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rPdL5sOQ4GFWV+a5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Overall it looks very nice, thanks.

On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L=F3pez wrote:
> +static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *=
priv,
> +                                                 struct sun4i_dma_vchan =
*vchan)
> +{
> +       struct sun4i_dma_pchan *pchan =3D NULL, *pchans =3D priv->pchans;
> +       unsigned long flags;
> +       int i, max;
> +
> +       /*
> +        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
> +        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
> +        */
> +       if (vchan->is_dedicated) {
> +               i =3D NDMA_NR_MAX_CHANNELS;
> +               max =3D DMA_NR_MAX_CHANNELS;
> +       } else {
> +               i =3D 0;
> +               max =3D NDMA_NR_MAX_CHANNELS;
> +       }
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +       for_each_clear_bit_from(i, &priv->pchans_used, max) {
> +               pchan =3D &pchans[i];
> +               pchan->vchan =3D vchan;
> +               set_bit(i, priv->pchans_used);
> +               break;

ffz instead?

> +static int execute_vchan_pending(struct sun4i_dma_dev *priv,
> +				 struct sun4i_dma_vchan *vchan)
> +{
> +	struct sun4i_dma_promise *promise =3D NULL;
> +	struct sun4i_dma_contract *contract =3D NULL;
> +	struct sun4i_dma_pchan *pchan;
> +	struct virt_dma_desc *vd;
> +	int ret;
> +
> +	lockdep_assert_held(&vchan->vc.lock);

So this has to be called with a lock taken?

You should mention that somewhere.
Usually, such fonctions are also prefixed by "__"

> +/**
> + * Generate a promise, to be used in a normal DMA contract.
> + *
> + * A NDMA promise contains all the information required to program the
> + * normal part of the DMA Engine and get data copied. A non-executed
> + * promise will live in the demands list on a contract. Once it has been
> + * completed, it will be moved to the completed demands list for later f=
reeing.
> + * All linked promises will be freed when the corresponding contract is =
freed
> + */
> +static struct sun4i_dma_promise *
> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t =
dest,
> +		      size_t len, struct dma_slave_config *sconfig)
> +{
> +	struct sun4i_dma_promise *promise;
> +	int ret;
> +
> +	promise =3D kzalloc(sizeof(*promise), GFP_NOWAIT);
> +	if (!promise)
> +		return NULL;
> +
> +	promise->src =3D src;
> +	promise->dst =3D dest;
> +	promise->len =3D len;
> +	promise->cfg =3D NDMA_CFG_LOADING | NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
> +
> +	/* Use sensible default values if client is using undefined ones */
> +	if (sconfig->src_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		sconfig->src_addr_width =3D sconfig->dst_addr_width;
> +	if (sconfig->dst_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		sconfig->dst_addr_width =3D sconfig->src_addr_width;
> +	if (sconfig->src_maxburst =3D=3D 0)
> +		sconfig->src_maxburst =3D sconfig->dst_maxburst;
> +	if (sconfig->dst_maxburst =3D=3D 0)
> +		sconfig->dst_maxburst =3D sconfig->src_maxburst;

I'm not sure what's the default policy on that. Vinod?

> +static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
> +{
> +	struct sun4i_dma_dev *priv =3D dev_id;
> +	struct sun4i_dma_vchan *vchan;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i =3D 0; i < DMA_NR_MAX_VCHANS; i++) {
> +		vchan =3D &priv->vchans[i];
> +		spin_lock_irqsave(&vchan->vc.lock, flags);
> +		execute_vchan_pending(priv, vchan);
> +		spin_unlock_irqrestore(&vchan->vc.lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

Judging from Russell's comment here, that should be in the interrupt
handler

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277737.ht=
ml

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rPdL5sOQ4GFWV+a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4TfqAAoJEBx+YmzsjxAgyXIP/jspmZioAb8mWDks383GWweH
Q4wv2EHPuCBD2IQAb4YmUF52EakhNPJtmwkYLhEdcQjQyBRAFyF4wMKyUtTpF37u
JEh68uUgCpxy0twpV2KZvFV2WoxEFa8ycaYfzIokTNnN/hmxr/YUsADPwFH1sLRS
t1znLfWgHrfjDmBm8ZYk4kSaNFartXxFnx0DH3gFyD32gcRDoSOXkGb0IxcgVIyD
xSbXFljAsr0AD5We81BnqGc+E3ryLL0meOdjZLGEnD38V0DTyfMVccOJAFmahy6v
TVCQr0q2LJEYQNRAkg3mcIDtovSqnmdDYddBzYT19Ij6eVMjWomzhus0KTJXHRsS
0zpPqEk6OGeOaExa/vhbVMAwFjujjLS+IG9PyQVqDLdGM/z3aSmp9XE3LKVv1ndH
8t6WtqbnxiED9KLv7dgCBaONCq0Uc4/AjLljEua9bQkOEbnniVwpy6BE3ksl3Tmw
xpCFtbkkm1v9HFALglaMFBw/Cxd0xePqXR+2G7c07TOv1rglYN7URBQIZVe2COpw
j9U1hnNpU3JoD4k5Zo1jeGidGZWeoViGvQeu4QAcSOV4vBr4G9efVuQijYNql3Ck
8fv5QTgUz8QN/16r08ON4DqpA07GzCE540x2m0umYafrhUn5hcIab6fC9lRLUPmi
UFy11/WDq2RzxCGQm4Uq
=Nd6l
-----END PGP SIGNATURE-----

--rPdL5sOQ4GFWV+a5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
