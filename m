From: Ben Whitten <Ben.Whitten@lairdtech.com>
Subject: RE: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Wed, 4 Jul 2018 13:41:42 +0000
Message-ID: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Steve deRosier <derosier@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Jiri Pirko <jiri@resnulli.us>, Hasnain Virk <Hasnain.Virk@arm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?iso-8859-1?Q?Michael_R=F6der?= <michael.roeder@avnet.eu>,
 Janus Piwek <jpiwek@arroweurope.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 "David S . Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Andreas_F=E4rber?=
 <afaerber@suse.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180704114355.GB11693@sirena.org.uk>
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

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
> =

> On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F=E4rber wrote:
> =

> > Do you have an alternative solution for abstraction? A regmap would seem
> > to require putting everything into a monolithic SX1301 driver despite
> > those connected chipsets actually being regular, external SPI chips that
> > could also be attached to non-SX1301 SPI masters.
> =

> I'm suggesting a regmap for those external SPI chips.  It doesn't matter
> what the host uses.

Currently in my testing drivers I have used regmap for both the SX1301 and =
the downstream SX1257.
In my SX1257 driver currently the regmap is backed via SPI with devm_regmap=
_init_spi, please correct me if I am wrong but if I understand correctly th=
is could be split out to regmap backed by SPI in the case of a direct host =
connection, and a regmap backed by the SX1301's regmapped strobing register=
 interface, regmap_bus?
Is there a precedent to this I can examine?
