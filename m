From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
Date: Mon, 16 Jul 2018 21:11:09 -0700
Message-ID: <CAHQ1cqHPgL0k9Av6m3gxkeT=YpaaK9+Wm4Lagp+GXo-nH+OBnw@mail.gmail.com>
References: <20180716062508.7726-1-andrew.smirnov@gmail.com> <20180716112629.GC20734@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: maitysanchayan@gmail.com, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716112629.GC20734@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 16, 2018 at 4:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jul 15, 2018 at 11:25:08PM -0700, Andrey Smirnov wrote:
> > Users of SPI device drivers may rely on 'actual_length', so it is
> > important that information is correctly reported. One example would be
> > spi_mem_exec_op() which will fail if 'actual_length' doesn't match
> > requested transfer length. To fix the problem, add necessary code to
> > populate 'actual_length'.
>
> This doesn't apply against current code, please check and resend.


Sorry about that. Will do in v2.

Thanks,
Andrey Smirnov
