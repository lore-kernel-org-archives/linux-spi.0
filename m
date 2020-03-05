From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
Date: Thu, 5 Mar 2020 15:00:22 +0200
Message-ID: <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com> <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200305121202.GB4046@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Mar 05, 2020 at 12:00:39AM +0200, Vladimir Oltean wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > When dealing with a SPI controller driver that is sending more than 1
> > byte at once (or the entire buffer at once), and the SPI peripheral
> > driver has requested timestamping for a byte in the middle of the
> > buffer, we find that spi_take_timestamp_pre never records a "pre"
> > timestamp.
>
> This is a fix and so should have been at the start of the series to make
> sure there aren't any dependencies.

My reasoning for not submitting it as a fix is:
- The only driver that uses the functionality so far - spi-fsl-dspi -
has worked thus far even with the limitation that only byte-by-byte
transfers were supported properly.
- I removed the limitation before actually changing the operating mode
of spi-fsl-dspi. Therefore the limitation is effectively never seen.
- New SPI drivers that would want to make use of software timestamping
would do so through your SPI for-next branch anyway, where the
limitation would be, again, fixed.

Thanks,
-Vladimir
