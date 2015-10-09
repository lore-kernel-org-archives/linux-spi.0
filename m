From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 06/10] dmaengine: add API for getting dma
 controller's quirk
Date: Fri, 9 Oct 2015 19:31:21 +0800
Message-ID: <5617A589.4090102@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com> <561629D6.9010702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561629D6.9010702-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=E5=9C=A8 2015/10/8 16:31, Lars-Peter Clausen =E5=86=99=E9=81=93:
> On 10/06/2015 11:21 AM, Shawn Lin wrote:
>> Hi Vinod,
>>
>> On 2015/10/5 23:37, Vinod Koul wrote:
>>> On Mon, Sep 14, 2015 at 07:48:59AM +0800, Shawn Lin wrote:
>>>> Add dmaengine_get_quirks API for peripheral devices to query
>>>> quirks if they need it to make special workaround due to broken
>>>> dma controller design.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> ---
>>>>
>>>> Changes in v5: None
>>>> Changes in v4: None
>>>> Changes in v3: None
>>>> Changes in v2: None
>>>> Changes in v1: None
>>>>
>>>>    include/linux/dmaengine.h | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>>> index e2f5eb4..5174ca4 100644
>>>> --- a/include/linux/dmaengine.h
>>>> +++ b/include/linux/dmaengine.h
>>>> @@ -704,6 +704,7 @@ struct dma_device {
>>>>
>>>>        int (*device_config)(struct dma_chan *chan,
>>>>                     struct dma_slave_config *config);
>>>> +    int (*device_get_quirks)(struct dma_chan *chan);
>>>
>>> And why do we want to expose this to users? THis doesnt seem right!
>>>
>>
>> Basically I agree not to expose dma's quirk to slave controllers...B=
ut, the
>> fact I mentioned on cover letter explain the reasons why I have to l=
et slave
>> controllers know that they are working with a broken dma. It's a dil=
emma
>> that if we don't want that to be exposed(let slave controllers' driv=
er get
>> the info via a API), we have t add broken quirk for all of them ,her=
e and
>> there, which seems to be a disaster:(
>
> The problem with this API is that it transports values with device sp=
ecific
> meanings over a generic API. Which is generally speaking not a good i=
dea
> because the consumer witch is supposed to be generic suddenly needs t=
o know
> which provider it is talking to.
>
> A better solution in this case typically is either introduce a generi=
c API
> with generic values or a custom API with custom values, but don't mix=
 the two.
>
>>
>> I would appreciate it if you could give me some suggestions at your =
earliest
>> convenience. :)
>
> In this case I think the best way to handle this is not quirks, but r=
ather
> expose the actual maximum burst size using the DMA capabilities API. =
Since
> supporting only a certain burst depth is not really a quirk. All hard=
ware
> has a limit for this and for some it might be larger or smaller than =
for
> others and it might be the same IP core but the maximum size depends =
on some
> IP core parameters. So this should be discoverable.
>

Hi Lars,

Thanks for looking for that.

It's a good idea if all clients of the Soc are broken, but unfortunatel=
y=20
some of them work. So... max burst shoule be different for individuals.

> - Lars
>
>
>
>


--=20
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
