From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Tue, 3 Jul 2018 17:09:38 +0200
Message-ID: <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: Steve deRosier <derosier@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Jiri Pirko <jiri@resnulli.us>, Ben Whitten <ben.whitten@lairdtech.com>,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
 Janus Piwek <jpiwek@arroweurope.com>, linux-spi@vger.kernel.org,
 LoRa_Community_Support@semtech.com, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 Ken Yu <ken.yu@rakwireless.com>, "David S . Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180703145022.GA13744@sirena.org.uk>
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

Am 03.07.2018 um 16:50 schrieb Mark Brown:
> On Mon, Jul 02, 2018 at 07:34:21PM +0200, Andreas F=E4rber wrote:
>> Hi Mark,
>>
>> This driver is still evolving, there's newer code on my lora-next branch
>> already: https://github.com/afaerber/linux/commits/lora-next
> =

> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

I did reply inline, if you cared to read on. ;)

>> 2) This SPI device is in turn exposing the two SPI masters that you
>> already found below, and I didn't see a sane way to split that code out
>> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
>> any precedence either way?
> =

> A MFD?

I know of mfd, but how would the the the net vs. spi pieces interact
then? Some functions would need to be exported then or is there an
easier way without needing to set a cross-module API in stone?

>> Am 02.07.2018 um 18:12 schrieb Mark Brown:
>>> On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:
>>>> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enab=
le)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
>>>> +
>>>> +	if (enable)
>>>> +		return;
> =

>>> So we never disable chip select?
> =

>> Not here, I instead did that in transfer_one below.
> =

> That's obviously at best going to be fragile, you're implementing half
> the operation here and half somewhere else which is most likely going to
> break at some point when the framework changes.
> =

>>>> +		if (ret) {
>>>> +			dev_err(&spi->dev, "SPI radio address write failed\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx=
_buf && xfr->len >=3D 2) ? tx_buf[1] : 0);
>>>> +		if (ret) {
>>>> +			dev_err(&spi->dev, "SPI radio data write failed\n");
>>>> +			return ret;
>>>> +		}
> =

>>> This looks awfully like you're coming in at the wrong abstraction layer
>>> and the hardware actually implements a register abstraction rather than
>>> a SPI one so you should be using regmap as the abstraction.
> =

>> I don't understand. Ben has suggested using regmap for the SPI _device_
>> that we're talking to, which may be a good idea. But this SX1301 device
>> in turn has two SPI _masters_ talking to an SX125x slave each. I don't
>> see how using regmap instead of my wrappers avoids this spi_controller?
> =

> It seems obvious from the code that this isn't actually interacting with
> a SPI controller, you're writing an address and a value to a register
> map rather than dealing with a byte stream.  There may be a SPI bus
> somewhere behind some other hardware but you don't seem to be
> interacting with it as such.
> =

>> The whole point of this spi_controller is to abstract and separate the
>> SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
>> instead of mixing it into the SX1301 driver - to me that looks cleaner
>> and more extensible. It also has the side-effect that we could configure
>> the two radios via DT (frequencies, clk output, etc.).
> =

> A register map would work just as well here, we already have plenty of
> devices that abstract at this level (most obviously the I2C/SPI devices
> that use it to offer both interfaces with a single core driver).

The address and data registers together form a two-byte SPI message!

It is transmitted by writing to the CS register.

The received data is afterwards available in another register.

HTE,
Andreas

-- =

SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
