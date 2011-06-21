From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: Slow spi_sync() on pxa2xx_spi
Date: Tue, 21 Jun 2011 16:03:41 +0200
Message-ID: <20110621140341.GK3652@excalibur.local>
References: <20110616082112.GA10075@excalibur.local>
	<BANLkTikuo_fHbw9FFMtorpg15vOnXMK-+g@mail.gmail.com>
	<20110616091931.GB10075@excalibur.local>
	<BANLkTinU+chEbZRpFSdRH_dPE2vhK_7pHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	Stefan Schmidt <stefan@datenfreihafen.org>
To: Eric Miao <eric.y.miao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinU+chEbZRpFSdRH_dPE2vhK_7pHg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello.

On Thu, 2011-06-16 at 17:44, Eric Miao wrote:
> On Thu, Jun 16, 2011 at 5:19 PM, Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
> >
> > Its either 8bit or 16bit for a message. The mentioned problem happens
> > on a 8 bit message. It does nothing else then writing to a defined
> > register address to trigger the hardware sending the data in the FIFO.
> 
> This might get too much overhead. I didn't check the source code, but
> my guess is it's waiting for interrupt for each message, and once the
> interrupt of message being flushed out happens, it starts the next one
> waiting for the FIFO empty interrupt coming. Did you try stuff more
> bytes into a single message?

Took me some time to implement and test al kind of different
scenarios. As you suggested I tried to stuff more bytes into a message
as well as testing all kind of combination with tx and rx thresholds,
timout, PIO and DMA, cs_change , etc. No change.

I then bit the bullet and changed the board to use the spi_gpio driver
instead of pxa2xx. After some struggling (make sure you setup pin
config correctly :)) I got it working but with the same result.

My last test block was around using spi_async() instead of spi_sync
and as well I was not able to reach my timing criteria. :(

To me it seems right now as if it is just not possible to reach
something in the 100 usec range with the SPI framework. Obviuously I
would be loved to be proven wrong. :)

As I'm running way out of time for this part of my project I'm back to
the driver now trying to find a solution that avoids the tight timing
criteria.

Eric, thanks again for your fast and helpfull mails.

regards
Stefan Schmidt
