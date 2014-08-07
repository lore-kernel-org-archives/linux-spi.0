From: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: Re: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
Date: Thu, 07 Aug 2014 16:37:16 -0300
Message-ID: <53E3D56C.5030204@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar> <1407183002-29420-2-git-send-email-emilio@elopez.com.ar> <20140805200042.GO3952@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140805200042.GO3952@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

El 05/08/14 a las 17:00, Maxime Ripard escibi=C3=B3:
> Hi,
>
> Overall it looks very nice, thanks.
>
> On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L=C3=B3pez wrote:
>> +static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_=
dev *priv,
>> +                                                 struct sun4i_dma_v=
chan *vchan)
>> +{
>> +       struct sun4i_dma_pchan *pchan =3D NULL, *pchans =3D priv->pc=
hans;
>> +       unsigned long flags;
>> +       int i, max;
>> +
>> +       /*
>> +        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
>> +        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
>> +        */
>> +       if (vchan->is_dedicated) {
>> +               i =3D NDMA_NR_MAX_CHANNELS;
>> +               max =3D DMA_NR_MAX_CHANNELS;
>> +       } else {
>> +               i =3D 0;
>> +               max =3D NDMA_NR_MAX_CHANNELS;
>> +       }
>> +
>> +       spin_lock_irqsave(&priv->lock, flags);
>> +       for_each_clear_bit_from(i, &priv->pchans_used, max) {
>> +               pchan =3D &pchans[i];
>> +               pchan->vchan =3D vchan;
>> +               set_bit(i, priv->pchans_used);
>> +               break;
>
> ffz instead?

I think it'd look way more messy with ffz, as it only works on unsigned=
=20
longs and it's undefined on the all-1s case.

We could have something like this, but I don't see much point in what's=
=20
basically expanding the macro

	spin_lock_irqsave(&priv->lock, flags);
	i =3D find_next_zero_bit(&priv->pchans_used, max, i);
	if (i < max) {
		pchan =3D &pchans[i];
		pchan->vchan =3D vchan;
		set_bit(i, priv->pchans_used);
	}
	spin_unlock_irqrestore(&priv->lock, flags);

>> +static int execute_vchan_pending(struct sun4i_dma_dev *priv,
>> +				 struct sun4i_dma_vchan *vchan)
>> +{
>> +	struct sun4i_dma_promise *promise =3D NULL;
>> +	struct sun4i_dma_contract *contract =3D NULL;
>> +	struct sun4i_dma_pchan *pchan;
>> +	struct virt_dma_desc *vd;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&vchan->vc.lock);
>
> So this has to be called with a lock taken?
>
> You should mention that somewhere.
> Usually, such fonctions are also prefixed by "__"

Ok, I added a comment and the prefix now.

>> +/**
>> + * Generate a promise, to be used in a normal DMA contract.
>> + *
>> + * A NDMA promise contains all the information required to program =
the
>> + * normal part of the DMA Engine and get data copied. A non-execute=
d
>> + * promise will live in the demands list on a contract. Once it has=
 been
>> + * completed, it will be moved to the completed demands list for la=
ter freeing.
>> + * All linked promises will be freed when the corresponding contrac=
t is freed
>> + */
>> +static struct sun4i_dma_promise *
>> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_ad=
dr_t dest,
>> +		      size_t len, struct dma_slave_config *sconfig)
>> +{
>> +	struct sun4i_dma_promise *promise;
>> +	int ret;
>> +
>> +	promise =3D kzalloc(sizeof(*promise), GFP_NOWAIT);
>> +	if (!promise)
>> +		return NULL;
>> +
>> +	promise->src =3D src;
>> +	promise->dst =3D dest;
>> +	promise->len =3D len;
>> +	promise->cfg =3D NDMA_CFG_LOADING | NDMA_CFG_BYTE_COUNT_MODE_REMAI=
N;
>> +
>> +	/* Use sensible default values if client is using undefined ones *=
/
>> +	if (sconfig->src_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
>> +		sconfig->src_addr_width =3D sconfig->dst_addr_width;
>> +	if (sconfig->dst_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
>> +		sconfig->dst_addr_width =3D sconfig->src_addr_width;
>> +	if (sconfig->src_maxburst =3D=3D 0)
>> +		sconfig->src_maxburst =3D sconfig->dst_maxburst;
>> +	if (sconfig->dst_maxburst =3D=3D 0)
>> +		sconfig->dst_maxburst =3D sconfig->src_maxburst;
>
> I'm not sure what's the default policy on that. Vinod?
>
>> +static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
>> +{
>> +	struct sun4i_dma_dev *priv =3D dev_id;
>> +	struct sun4i_dma_vchan *vchan;
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	for (i =3D 0; i < DMA_NR_MAX_VCHANS; i++) {
>> +		vchan =3D &priv->vchans[i];
>> +		spin_lock_irqsave(&vchan->vc.lock, flags);
>> +		execute_vchan_pending(priv, vchan);
>> +		spin_unlock_irqrestore(&vchan->vc.lock, flags);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>
> Judging from Russell's comment here, that should be in the interrupt
> handler
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277=
737.html

Wouldn't that make the interrupt handler quite big time wise? I was=20
under the impression they should remain as short as possible. LDD3 says=
=20
"The programmer should be careful to write a routine that executes in a=
=20
minimum amount of time (...)" on chapter 10

I did try something mid-way a bit ago; I added code to see if we could=20
issue the next DMA operation from the current set, but it was just extr=
a=20
complexity for a noop in performance, as they're sets of one on all=20
cases I tried.

It's worth noting that the very latency sensitive DMA users we will hav=
e=20
(ie, audio) are already completely managed in the IRQ handler thanks to=
=20
the less flexible concept of cyclic transfers.

Cheers,

Emilio
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
