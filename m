From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v5 06/10] dmaengine: add API for getting
 dma controller's quirk
Date: Fri, 09 Oct 2015 13:38:05 +0200
Message-ID: <5617A71D.4030006@metafoo.de>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com> <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com> <20151005153746.GG13501@vkoul-mobl.iind.intel.com> <56139289.7000005@rock-chips.com> <561629D6.9010702@metafoo.de> <5617A589.4090102@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Addy Ke <addy.ke@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Takashi Iwai <tiwai@suse.com>, dmaengine@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Sonny Rao <sonnyrao@chromium.org>,
	linux-arm-kernel@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Vinod Koul <vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5617A589.4090102@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/09/2015 01:31 PM, Shawn Lin wrote:
> =E5=9C=A8 2015/10/8 16:31, Lars-Peter Clausen =E5=86=99=E9=81=93:
>> On 10/06/2015 11:21 AM, Shawn Lin wrote:
>>> Hi Vinod,
>>>
>>> On 2015/10/5 23:37, Vinod Koul wrote:
>>>> On Mon, Sep 14, 2015 at 07:48:59AM +0800, Shawn Lin wrote:
>>>>> Add dmaengine_get_quirks API for peripheral devices to query
>>>>> quirks if they need it to make special workaround due to broken
>>>>> dma controller design.
>>>>>
>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>> ---
>>>>>
>>>>> Changes in v5: None
>>>>> Changes in v4: None
>>>>> Changes in v3: None
>>>>> Changes in v2: None
>>>>> Changes in v1: None
>>>>>
>>>>>    include/linux/dmaengine.h | 9 +++++++++
>>>>>    1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.=
h
>>>>> index e2f5eb4..5174ca4 100644
>>>>> --- a/include/linux/dmaengine.h
>>>>> +++ b/include/linux/dmaengine.h
>>>>> @@ -704,6 +704,7 @@ struct dma_device {
>>>>>
>>>>>        int (*device_config)(struct dma_chan *chan,
>>>>>                     struct dma_slave_config *config);
>>>>> +    int (*device_get_quirks)(struct dma_chan *chan);
>>>>
>>>> And why do we want to expose this to users? THis doesnt seem right=
!
>>>>
>>>
>>> Basically I agree not to expose dma's quirk to slave controllers...=
But, the
>>> fact I mentioned on cover letter explain the reasons why I have to =
let slave
>>> controllers know that they are working with a broken dma. It's a di=
lemma
>>> that if we don't want that to be exposed(let slave controllers' dri=
ver get
>>> the info via a API), we have t add broken quirk for all of them ,he=
re and
>>> there, which seems to be a disaster:(
>>
>> The problem with this API is that it transports values with device s=
pecific
>> meanings over a generic API. Which is generally speaking not a good =
idea
>> because the consumer witch is supposed to be generic suddenly needs =
to know
>> which provider it is talking to.
>>
>> A better solution in this case typically is either introduce a gener=
ic API
>> with generic values or a custom API with custom values, but don't mi=
x the
>> two.
>>
>>>
>>> I would appreciate it if you could give me some suggestions at your=
 earliest
>>> convenience. :)
>>
>> In this case I think the best way to handle this is not quirks, but =
rather
>> expose the actual maximum burst size using the DMA capabilities API.=
 Since
>> supporting only a certain burst depth is not really a quirk. All har=
dware
>> has a limit for this and for some it might be larger or smaller than=
 for
>> others and it might be the same IP core but the maximum size depends=
 on some
>> IP core parameters. So this should be discoverable.
>>
>=20
> Hi Lars,
>=20
> Thanks for looking for that.
>=20
> It's a good idea if all clients of the Soc are broken, but unfortunat=
ely
> some of them work. So... max burst shoule be different for individual=
s.

Well, the dma_get_slave_caps() API works on a DMA channel, so I don't t=
hink
this will be a problem.

- Lars
