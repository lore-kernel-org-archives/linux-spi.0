From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Thu, 9 Aug 2018 11:21:34 -0400
Message-ID: <20180809152134.gcql2lsh4sigx3hg@x220t>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?utf-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Konstantin =?utf-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.co
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 11:02:45PM +0800, Jian-Hong Pan wrote:
...
> 
> For LoRaWAN, it is a star topology.
> 

In sense of 6LoWPAN that means "border router" in the middle which runs
radvd on it and sending RA messages. Then doing a route (or even allow nd
proxy) between capable $IPv6 (ethernet?) and LoRa 6LoWPAN interface.

All others listen for RA messages with PIO and doing autoconfiguration.
(In 6LoWPAN you would also pass a 6CO option to compress the PIO
prefix, which would make sense to fully elide all IP addresses in the
header).

- Alex
