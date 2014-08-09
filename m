From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
Date: Sat, 9 Aug 2014 11:11:59 -0400
Message-ID: <CAKON4Oz6c44SZ5tdQ2xi7ZKHX-GR_MRvyQJOBKuJEyg+hOYeKA@mail.gmail.com>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
	<1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
	<20140805200042.GO3952@lukather>
	<53E3D56C.5030204@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	ARM Linux Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E3D56C.5030204-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Aug 7, 2014 at 3:37 PM, Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org=
> wrote:
> Hi,
>
> El 05/08/14 a las 17:00, Maxime Ripard escibi=C3=B3:
>
>> Hi,
>>
>> Overall it looks very nice, thanks.
>>
>> On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L=C3=B3pez wrote:
>>>
>>> +static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma=
_dev
>>> *priv,
>>> +                                                 struct sun4i_dma_=
vchan
>>> *vchan)
>>> +{
>>> +       struct sun4i_dma_pchan *pchan =3D NULL, *pchans =3D priv->p=
chans;
>>> +       unsigned long flags;
>>> +       int i, max;
>>> +
>>> +       /*
>>> +        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
>>> +        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
>>> +        */
>>> +       if (vchan->is_dedicated) {
>>> +               i =3D NDMA_NR_MAX_CHANNELS;
>>> +               max =3D DMA_NR_MAX_CHANNELS;
>>> +       } else {
>>> +               i =3D 0;
>>> +               max =3D NDMA_NR_MAX_CHANNELS;
>>> +       }
>>> +
>>> +       spin_lock_irqsave(&priv->lock, flags);
>>> +       for_each_clear_bit_from(i, &priv->pchans_used, max) {
>>> +               pchan =3D &pchans[i];
>>> +               pchan->vchan =3D vchan;
>>> +               set_bit(i, priv->pchans_used);
>>> +               break;
>>
>>
>> ffz instead?
>
>
> I think it'd look way more messy with ffz, as it only works on unsign=
ed
> longs and it's undefined on the all-1s case.
>
> We could have something like this, but I don't see much point in what=
's
> basically expanding the macro
>
>         spin_lock_irqsave(&priv->lock, flags);
>         i =3D find_next_zero_bit(&priv->pchans_used, max, i);
>         if (i < max) {
>                 pchan =3D &pchans[i];
>                 pchan->vchan =3D vchan;
>                 set_bit(i, priv->pchans_used);
>         }
>         spin_unlock_irqrestore(&priv->lock, flags);
>
>
>>> +static int execute_vchan_pending(struct sun4i_dma_dev *priv,
>>> +                                struct sun4i_dma_vchan *vchan)
>>> +{
>>> +       struct sun4i_dma_promise *promise =3D NULL;
>>> +       struct sun4i_dma_contract *contract =3D NULL;
>>> +       struct sun4i_dma_pchan *pchan;
>>> +       struct virt_dma_desc *vd;
>>> +       int ret;
>>> +
>>> +       lockdep_assert_held(&vchan->vc.lock);
>>
>>
>> So this has to be called with a lock taken?
>>
>> You should mention that somewhere.
>> Usually, such fonctions are also prefixed by "__"
>
>
> Ok, I added a comment and the prefix now.
>
>
>>> +/**
>>> + * Generate a promise, to be used in a normal DMA contract.
>>> + *
>>> + * A NDMA promise contains all the information required to program=
 the
>>> + * normal part of the DMA Engine and get data copied. A non-execut=
ed
>>> + * promise will live in the demands list on a contract. Once it ha=
s been
>>> + * completed, it will be moved to the completed demands list for l=
ater
>>> freeing.
>>> + * All linked promises will be freed when the corresponding contra=
ct is
>>> freed
>>> + */
>>> +static struct sun4i_dma_promise *
>>> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_a=
ddr_t
>>> dest,
>>> +                     size_t len, struct dma_slave_config *sconfig)
>>> +{
>>> +       struct sun4i_dma_promise *promise;
>>> +       int ret;
>>> +
>>> +       promise =3D kzalloc(sizeof(*promise), GFP_NOWAIT);
>>> +       if (!promise)
>>> +               return NULL;
>>> +
>>> +       promise->src =3D src;
>>> +       promise->dst =3D dest;
>>> +       promise->len =3D len;
>>> +       promise->cfg =3D NDMA_CFG_LOADING |
>>> NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
>>> +
>>> +       /* Use sensible default values if client is using undefined=
 ones
>>> */
>>> +       if (sconfig->src_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEF=
INED)
>>> +               sconfig->src_addr_width =3D sconfig->dst_addr_width=
;
>>> +       if (sconfig->dst_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEF=
INED)
>>> +               sconfig->dst_addr_width =3D sconfig->src_addr_width=
;
>>> +       if (sconfig->src_maxburst =3D=3D 0)
>>> +               sconfig->src_maxburst =3D sconfig->dst_maxburst;
>>> +       if (sconfig->dst_maxburst =3D=3D 0)
>>> +               sconfig->dst_maxburst =3D sconfig->src_maxburst;
>>
>>
>> I'm not sure what's the default policy on that. Vinod?
>>
>>> +static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
>>> +{
>>> +       struct sun4i_dma_dev *priv =3D dev_id;
>>> +       struct sun4i_dma_vchan *vchan;
>>> +       unsigned long flags;
>>> +       int i;
>>> +
>>> +       for (i =3D 0; i < DMA_NR_MAX_VCHANS; i++) {
>>> +               vchan =3D &priv->vchans[i];
>>> +               spin_lock_irqsave(&vchan->vc.lock, flags);
>>> +               execute_vchan_pending(priv, vchan);
>>> +               spin_unlock_irqrestore(&vchan->vc.lock, flags);
>>> +       }
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>
>>
>> Judging from Russell's comment here, that should be in the interrupt
>> handler
>>
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/27=
7737.html
>
>
> Wouldn't that make the interrupt handler quite big time wise? I was u=
nder
> the impression they should remain as short as possible. LDD3 says "Th=
e
> programmer should be careful to write a routine that executes in a mi=
nimum
> amount of time (...)" on chapter 10
>
> I did try something mid-way a bit ago; I added code to see if we coul=
d issue
> the next DMA operation from the current set, but it was just extra
> complexity for a noop in performance, as they're sets of one on all c=
ases I
> tried.
>
> It's worth noting that the very latency sensitive DMA users we will h=
ave
> (ie, audio) are already completely managed in the IRQ handler thanks =
to the
> less flexible concept of cyclic transfers.

Other things are latency sensitive like ADC inputs. Plus adding
latency lowers the throughput of SPI and whoever else is using the
channels.

Running that code is probably just a few microseconds, not enough to
mess up overall system latency. Things that mess up system latency are
in the millisecond range.

Another thing I do in my IRQ handlers is re-read the interrupt status
register right before returning.  Then loop if any new IRQs have
asserted.   The network drivers all do this, they call it IRQ
mitigation.  Consider multiple Gbe interfaces getting hit by billions
of tiny packets. But doing IRQ mitigation you can eliminate millions
of pointless interrupts.


>
> Cheers,
>
> Emilio
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
