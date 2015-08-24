From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Mon, 24 Aug 2015 09:51:40 +0100
Message-ID: <20150824085140.GA5647@ck-lbox>
References: <CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
 <CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
 <20150819134328.GU1552@lahna.fi.intel.com>
 <CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
 <20150820094542.GC30005@lahna.fi.intel.com>
 <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
 <20150820115845.GF30005@lahna.fi.intel.com>
 <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 dan.carpenter@oracle.com
To: Christian Hartmann <cornogle@googlemail.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 21, 2015 at 02:09:46PM +0200, Christian Hartmann wrote:
> Hi
> 
> 2015-08-21 9:43 GMT+02:00 Mika Westerberg <mika.westerberg@linux.intel.com>:
> > So please drop the code in 1) to be able to request the GPIO in the
> > driver.
> 
> [    6.129664] spi spi-WM510205:00: 8333333 Hz actual, PIO
> [    6.129675] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
> [    6.129759] spi spi-WM510205:00: checking WM510205 with bmp180
> [    6.129765] spi spi-WM510205:00: checking WM510205 with bmp181
> [    6.129797] spi spi-WM510205:00: modalias WM510205 in id_table not
> found, returns NULL
> [    6.129825] arizona spi-WM510205:00: arizona_acpi_get_type(), than
> via spi_get_device_id().
> [    6.129831] arizona spi-WM510205:00: arizona_acpi_get_type matched
> [    6.129836] arizona spi-WM510205:00: using 1 as type for arizona audio codec
> [    6.129840] arizona spi-WM510205:00: regmap set to wm5102_spi
> [    6.130630] arizona spi-WM510205:00: spi_irq = -1
> [    6.130638] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
> [    6.144806] arizona spi-WM510205:00: found device ID: ffff
> [    6.175352] arizona spi-WM510205:00: Unknown device ID ffff
> [    6.175584] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
> [    6.177870] sst-acpi 80860F28:00: No matching ASoC machine driver found
> 
> as you said, I removed the code in 1) so the EBUSY error is gone.
> 
> What is with the spi_irq = -1 ?? is this a problem here?

The IRQ needs pulled from the ACPI as well, having no IRQ
specified will not interfer with basic functionality of the
driver but will become a problem eventually.

Thanks,
Charles
