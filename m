From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH] spi: add spi_sync_single_transfer wrapper for single
 spi_transfer
Date: Fri, 17 Jun 2016 20:38:31 +0900
Message-ID: <20160617113831.GB10760@jack.zhora.eu>
References: <1466034046-718-1-git-send-email-andi.shyti@samsung.com>
 <CGME20160616161054epcas1p26a6616bcb99a3375eee6c11c76117d76@epcas1p2.samsung.com>
 <5762CF88.4060800@metafoo.de>
 <20160617004311.GA911@samsunx.samsung>
 <20160617113453.GG26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi.shyti@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160617113453.GG26099@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 17, 2016 at 12:34:53PM +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 09:43:11AM +0900, Andi Shyti wrote:
> 
> > > > The spi_sync_single_transfer function calls spi_sync_transfer
> > > > with a single spi_transfer element, instead of an array.
> 
> > > So, what's the advantage of using this as opposed to calling
> > > spi_sync_transfer with a 1 for the number of transfers?
> 
> > Not much, but it keeps the code a bit nicer to read for those
> > using spi_sync_transfer with only one spi_transfer. Besides it's
> > also more understandable what the function itself does and there
> > would not be any need to jump into the spi_sync_transfer to check
> > what the number '1' is needed for (for example it's not a boolean 
> > 'true' value).
> 
> I really don't think this has been a big source of confusion for people.

OK, nevermind, then :)

Thanks,
Andi
