From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 3/9] spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
Date: Mon, 25 Mar 2019 10:52:35 +0100
Message-ID: <a032aeb1-7c08-2159-87ab-eaabedf6def8@i2se.com>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-4-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel@martin.sperl.org, Mark Brown <broonie@kernel.org>,
 Eric Anholt <eric@anholt.net>, Hubert Denkmair <h.denkmair@intence.de>,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190324175002.28969-4-kernel@martin.sperl.org>
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

Hi Martin,

here is my suggestion for a subject:

spi: bcm2835aux: fix corruptions for longer spi transfers

Am 24.03.19 um 18:49 schrieb kernel@martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> On long running tests with a mcp2517fd can controller it showed that
> on rare occations the data read shows corruptions for longer spi transfers.
>
> Example of a 22 byte transfer:
>
> expected (as captured on logic analyzer):
> FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 85 86 87 88 89 8a 8b
>
> read by the driver:
> FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 88 89 8a 00 00 8b 9b
>
> To fix this use BCM2835_AUX_SPI_STAT_RX_LVL to determine when we may
> read data from the fifo reliably without any corruption.
>
> Surprisingly the only values ever empirically read in
> BCM2835_AUX_SPI_STAT_RX_LVL are 0x00, 0x10, 0x20 and 0x30.
> So whenever the mask is not 0 we can read from the fifo in a safe manner.
>
> The patch has now been tested intensively and we are no longer
> able to reproduce the "RX" issue any longer.
>
> Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e

Please use a proper fixes tages in all of your patches. Doesn't
checkpatch.pl complain about it?

Thanks Stefan
