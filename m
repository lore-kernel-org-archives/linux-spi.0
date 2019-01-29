From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for devices
Date: Tue, 29 Jan 2019 17:04:15 +0800
Message-ID: <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
References: <20190126163220.26421-1-jonas@norrbonn.se> <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk> <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Jonas,
On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
> On 28/01/2019 19:10, Mark Brown wrote:
> > On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
> >
> >> @@ -164,6 +166,7 @@ struct spi_device {
> >>      char                    modalias[SPI_NAME_SIZE];
> >>      const char              *driver_override;
> >>      int                     cs_gpio;        /* chip select gpio */
> >> +    uint16_t                word_delay;     /* inter-word delay (us) */
> >
> > This needs some code in the core joining it up with the per-transfer
> > word delay similar to what we have for speed_hz and bits_per_word in
> > __spi_validate().  Then the controller drivers can just look at the
> > per-transfer value and support both without having to duplicate logic.
> >
>
> So spi_transfer already has a field word_delay and it's defined as
> _clock cycles_ to delay between words.  I defined word_delay in
> spi_device as _microseconds_ to delay along the lines of delay_usecs.
>
> Given that the inter-word delay is a function of the slave device speed
> and not of the SPI bus speed, I'm inclined to say that a time-based
> delay is what we want (to be independent of bus speed).  As such, I want
> to know if I should add word_delay_usecs to _both_ spi_transfer and
> spi_device?
>
> There's only one user of word_delay from spi_transfer.  Just looking at
> it quickly, it looks like it wants the word_delay in
> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
> that to be microseconds and do the calculation in the driver?

The Spreadtrum SPI controller's word delay unit is clock cycle of the
SPI clock, since the SPI source clock can be changed, we can not force
user to know the real microseconds. But can we change it to a union
structure? not sure if this is a good way.

union {
     int word_delay_us;
     int word_delay_cycle;
} w;

-- 
Baolin Wang
Best Regards
