From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Tue, 6 Jan 2015 22:15:47 +0100
Message-ID: <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
References: <1420472564.803.9.camel@gmail.com> <20150105154834.GV11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Stefan Roese <sr@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150105154834.GV11764@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 5 January 2015 at 16:48, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jan 05, 2015 at 04:42:44PM +0100, Esben Haabendal wrote:
>
>> Please consider commit 4302a59629f7a0bd70fd1605d2b558597517372a
>> (spi: fsl: Fix problem with multi message transfers) for inclusion in
>> stable kernel 3.14.
>
>> It fixes a regression when using mmc_spi driver on top of spi-fsl-spi
>> driver (tested with powerpc mpc8313 based board).
>
> Has this ever worked?

Yes, I have used mmc_spi with spi-fsl-spi on the same board with success
with in 2.6.33, 3.0 and 3.4.

I have no idea what has caused this to break.  Maybe mmc_spi driver was
not doing multi message transfers earlier?

/Esben
