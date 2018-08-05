From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: Re: linux-lora.git and LoRaWAN (was: [RFC net-next 00/15] net: A
 socket API for LoRa)
Date: Sun, 5 Aug 2018 20:49:31 +0800
Message-ID: <CAC=mGzhtr0SuOmgJpcXODAzTzSb3xKSnyy9bnq37NuM8fDqBqQ@mail.gmail.com>
References: <20180701110804.32415-1-afaerber@suse.de> <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de> <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg0uP6ddm-kjev6JAH=GrKX9bT6s2canFOjKsC4rCcVAQ@mail.gmail.com> <6dda350b-66ab-b5ab-41ed-319b27e4e28c@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Ben Whitten <Ben.Whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>,
        "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>,
        Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>,
        "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
        Matthias Brugger <mbrugger-IBi9RG/b67k@public.gmane.org>,
        Janus Piwek <jpiwek-xaGqqxxtfCsTxu5ScYMnmg@public.gmane.org>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder-1xq/Wrep1TY@public.gmane.org>,
        Dollar Chen <dollar.chen-R57ae0ORxaEAvxtiuMwx3w@public.gmane.org>,
        Ken Yu <ken.yu-EUSmNabW1sldz2imjWt+ww@public.gmane.org>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm-5mkw0NDAAUY@public.gmane.org>,
        Jan Jongboom <jan.jongboom-5wv7dgnIgG8@public.gmane.org>,
        "contact-GpjyyWaKhplWk0Htik3J/w@public.gmane.org" <contact-GpjyyWaKhplWk0Htik3J/w@public.gmane.org>,
        Brian Ray <brian.ray-Uo9O3XgVypaakBO8gow8eQ@public.gmane.org>,
        "lora-SbRJF1/p8ws3UoVyvykmEw@public.gmane.org" <lo
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6dda350b-66ab-b5ab-41ed-319b27e4e28c-l3A5Bk7waGM@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Andreas,

2018-08-03 16:44 GMT+08:00 Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org>:
> Hi Jian-Hong,
>
> Am 02.08.2018 um 09:52 schrieb Jian-Hong Pan:
>> 2018-07-18 19:28 GMT+08:00 Ben Whitten <Ben.Whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>:
>>>> 1) PF_LORA/AF_LORA and associated identifiers are
>>>> proposed to represent
>>>>    this technology. While for an SX1276 [...] it
>>>> might work to
>>>>    layer LoRaWAN as a protocol option for PF_LORA and
>> add
>>>> LoRaWAN address
>>>>    fields to the union in my sockaddr_lora, how would that
>>>> work for devices
>>>>    that only support LoRaWAN but not pure LoRa? Do we
>>>> need both AF_LORA and
>>>>    AF_LORAWAN, or just a separate ETH_P_LORAWAN or
>>>> ARPHRD_LORAWAN?
> [...]
>>>> Meanwhile my attempt to play with netlink during SUSE
>>>> Hackweek has been
>>>> going slow and I could use some guidance or a volunteer to
>>>> contribute: I
>>>> have a bare skeleton of registration, commands, attributes
>>>> and multicast
>>>> groups, but no plan yet how to connect that to the actual
>>>> drivers to
>>>> query or apply the settings...
>>>
>>> Happy to help, I will be starting from zero on netlink but I can contri=
bute my existing work incorporating Marks comments for sx1301 etal.
>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/li
>>>> nux-lora.git/tree/net/lora/netlink.c?h=3Dlora-next
>>
>> Is this the repository used for the LoRa subsystem now?!!!
>> If it is, than great!
>
> Yes, my linux-lora.git contains this RFC patchset (modulo SX1276 fixes
> spotted by kbuild bot) plus a new serdev driver for another module and
> ongoing work by Ben and me for refactoring SX1301. It's monitored by the
> 0-day test service (kbuild bot).
>
> As this patchset was an RFC and does not have any Acked-bys from
> maintainers, the tree does not have a for-next branch integrated into
> linux-next on basis of 4.18-rc1, but instead (like my personal GitHub
> tree before) has a lora-next branch that rebases as patch queue on top
> of linux-next for now.
>
> The intent is to allow collaboration on getting things into a state that
> I can later submit a clean (squashed) RFC v2 for review, with all issues
> raised for this v1 addressed.
>
> For contributing patches to my linux-lora.git I suggest to use
> --subject-prefix=3D"PATCH lora-next" to distinguish from net-next.
> And I just realize I should add a MAINTAINERS entry in my tree to make
> sure patches CC me, too. (I do monitor netdev for patches with subject
> "lora", but chances are someone might omit that.)
>
>> As the previous mails, I am trying to implement the LoRaWAN
>> specification as the soft MAC as the MAC layer over LoRa PHY.
>> This is the the talk about LoRaWAN class module I gave in Netdev Conf
>> https://www.slideshare.net/chienhungpan/lorawan-class-module-and-subsyst=
em
>>
>> The expectation is:
>>
>> socket APIs:
>> send and receive the data
>> ------------------------------------------------------------
>> LoRaWAN class module implements MAC:
>> append the header/footer, encryption/decryption, timing slot and MAC com=
mands
>> ------------------------------------------------------------
>> LoRa device drivers:
>> send and receive the messages for MAC layer
>> ------------------------------------------------------------
>> LoRa devices
>
> Thanks for sharing your slides. We seem to be in alignment for the
> abstract concept above. The devil is in the implementation details. ^.-
>
>> Is it possible that combine the LoRaWAN class module I implemented?
>
> Yes, as stated in this cover letter, I would love if you could help
> merge your LoRaWAN implementation with my driver framework. Comparing
> 802.15.4 and 802.11, I think MAC code should go into net/maclorawan/ and
> then is a fairly independent module, with you as maintainer.
>
>> I start from the simplest class A end device's behavior, especially
>> the timing slot.
>> Also the encryption/decryption for uplink/downlink data messages.
>> I can send it as patches.
>>
>> However, I have 2 problems right now.
>> 1. Which Address and Protocol Family should we use?  PF_LORA or PF_LORAW=
AN?
>
> That was one of the questions I raised above. I now think we need both.
> I'm not yet too deep into LoRaWAN, but from the AT command interfaces
> I've seen there's confirmed and unconfirmed transmission modes that with
> PF_LORAWAN might be mapped to SOCK_STREAM and SOCK_DGRAM. Or do you see
> a way of doing both on a single PF_LORA SOCK_LORAWAN socket?
>
>> 2. To test the LoRaWAN class module, adding more procedures in LoRa
>> device drivers to register as a LoRaWAN device is needed.
>
> No, I don't think so. There are (at least) two types of devices, LoRaWAN
> and LoRa devices. The SX1276 is a pure LoRa device and thus should only
> expose a LoRa network device. It'll be the task of the maclorawan module
> to translate between the two layers, not the business of the device
> driver; SX1276 should receive a ready-to-send LoRa skb. For Ethernet,
> PF_INET and PF_INET6 don't need separate devices either, both use eth0.
>
> What I do think we need is your struct lora_hw, maybe renamed to
> lora_phy. That could be the missing piece for registration of the device
> drivers with nllora module?
> Note that similarly we'll also need an nllorawan module that needs to
> work both with your maclorawan and with some of my device drivers that
> implement the MAC in an MCU.

Let me think these twice.

> Additionally I've been looking into socket options at PF_LORA dgram
> layer for some radio options, but discarded that again for lack of
> precedence. Basically I wondered whether we could allow to choose SF,
> bandwidth, etc. on socket level and then apply those settings before
> sending one packet rather than expecting a global netlink operation that
> affects all sockets for that interface.

According to the LoRaWAN Regional Parameters, we should have the APIs
to set the SF, frequency, bandwidth ...
The idea is: LoRaWAN class module gets the region of this device and
the device's abilities.  Then LoRaWAN class module calls the callback
functions to set the related parameters: SF, frequency, bandwidth ...
And of course, the setting actions only happen in the idle, standby or
stop status.
1. Interface is being startup.
2. Requested by MAC command.

But let start from simple case and add more features and complexity in
the future.

By the way, I am rearranging the module's code and try to make it
could be patches.

Regards,
Jian-Hong Pan
