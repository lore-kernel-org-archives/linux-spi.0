From: kernel@martin.sperl.org
Subject: Re: [PATCH 0/9] spi: bcm2835aux: bug fixes and improvements
Date: Sun, 24 Feb 2019 21:11:23 +0100
Message-ID: <5A8B7C11-DB72-4384-945F-97D35554CFA6@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
 <1294540802.93488.1551036147867@email.ionos.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1294540802.93488.1551036147867@email.ionos.de>
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


> On 24.02.2019, at 20:22, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> 
>> Finally we remove some dead code.
>> 
>> Martin Sperl (9):
>>  spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
>>  spi: bcm2835aux: warn in dmesg that native cs is not really supported
>>  spi: bcm2835aux: setup gpio-cs to output and correct level during
>>    setup
>>  spi: bcm2835aux: add driver specific stats to debugfs
>>  spi: bcm2835aux: make the polling duration limits configurable
>>  spi: bcm2835aux: unifying code between polling and interrupt driven
>>    code
>>  spi: bcm2835aux: remove dangerous uncontrolled read of fifo
>>  spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
>>  spi: bcm2835aux: remove dead code
>> 
> 
> i consider patch 7 and 8 as possible stable candidates. How about rearranging this series that these patches comes first and could be backported?

Well - as far as I know 6+7+8 can get applied independently 
(and you will need 6 as otherwise you would need to apply
at least 8 in 2 places).

The one observation that I have made is that when applying those
against 4.14 you needed some more patches that have gone in since
4.14 to apply cleanly.

Martin
