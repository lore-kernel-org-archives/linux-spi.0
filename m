From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Sat, 11 Aug 2018 20:30:29 +0200
Message-ID: <e703bd38-f45d-6dda-b0e3-404598fd4bab@datenfreihafen.org>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mkubecek@suse.cz,
 =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
 shess@hessware.de, pieter.robyns@uhasselt.be, contact@snootlab.com,
 Xue Liu <liuxuenetmail@gmail.com>, Ken Yu <ken.yu@rakwireless.com>,
 =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
 Rob Herring <robh@kernel.org>, lora@globalsat.com.tw,
 Alexander Graf <agraf@suse.de>, Jan Jongboom <jan.jongboom@arm.com>,
 Janus Piwek <jpiwek@arroweurope.com>, Jon Ortego <Jon.Ortego@imst.de>,
 devicetree@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Hasnain Virk <Hasnain.Virk@arm.com>, Daniele Comel <dcomel@mipot.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Dollar Chen <dollar.chen@wtmec.com>,
 Brian Ray <brian.ray@link-labs.com>, linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>, Ben Whitten <ben.whitten@lairdtech.c
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180810165711.59bf26f7@alans-desktop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello.

On 08/10/2018 05:57 PM, Alan Cox wrote:
> 
> Long term yes I think Alexander is right the inevitable fate of all
> networks is to become a link layer in order to transmit IP frames 8)

There should be a niche for both at the same time. LoRaWAN is relevant
right now and we should aim for making it possible to run a native Linux
gateway for it.

As for IP for long range low power there is the static context header
compression draft to adapt IPv6 to the characteristics for some use
cases of such networks. Implementing it within the existing 6lwopan
subsystem should be possible.

https://tools.ietf.org/html/draft-ietf-lpwan-ipv6-static-context-hc-16

regards
Stefan Schmidt
