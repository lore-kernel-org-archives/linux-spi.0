From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Sun, 12 Aug 2018 18:49:23 +0200
Message-ID: <e105cfad-6192-25fb-be1d-a105875bf7a2@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
 <e703bd38-f45d-6dda-b0e3-404598fd4bab@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>, mkubecek@suse.cz,
        Rob Herring <rob
To: Stefan Schmidt <stefan@datenfreihafen.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e703bd38-f45d-6dda-b0e3-404598fd4bab@datenfreihafen.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Am 11.08.2018 um 20:30 schrieb Stefan Schmidt:
> On 08/10/2018 05:57 PM, Alan Cox wrote:
>>
>> Long term yes I think Alexander is right the inevitable fate of all
>> networks is to become a link layer in order to transmit IP frames 8)
> 
> There should be a niche for both at the same time. LoRaWAN is relevant
> right now and we should aim for making it possible to run a native Linux
> gateway for it.

+1

> As for IP for long range low power there is the static context header
> compression draft to adapt IPv6 to the characteristics for some use
> cases of such networks. Implementing it within the existing 6lwopan
> subsystem should be possible.
> 
> https://tools.ietf.org/html/draft-ietf-lpwan-ipv6-static-context-hc-16

I'm open to supporting by appropriate design all kinds of upper layers
people want to experiment with. Review feedback for that is welcome.
However I don't intend to implement each of those myself, and hardcoding
them is not really an option so they must be in appropriate modules.

Do keep in mind that depending on vendor implementation we have between
26 and 2048 bytes MTU available, less based on regulatory requirements,
often below 256 bytes. The more space we take away for frame headers
just because they're somehow standardized will make it less useful.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
