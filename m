From: kernel@martin.sperl.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
Date: Sun, 20 Jan 2019 12:24:23 +0100
Message-ID: <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk> <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org> <20190115212539.GK5522@sirena.org.uk> <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org> <20190118191202.GG6260@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118191202.GG6260@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark!

> On 18.01.2019, at 20:12, Mark Brown <broonie@kernel.org> wrote:
> 
> On Fri, Jan 18, 2019 at 06:11:31PM +0100, kernel@martin.sperl.org wrote:
> 
>> Does something like this looks acceptable?
> 
> Yes, it does!

> 
>> SPI_CONTROLLER_MODE_EXCLUSIVE could replace the bus_lock_flag.
>> I am also not sure of the “convention” of memory mode (i.e
>> using mem_ops). Is it maybe implicitly spi_bus_locked - i.e
>> typically only a single device?
> 
> Yes, it does - we're basically handing over the entire SPI bus to
> another bit of hardware that will do memory mapped flash access so we
> can't really have anything else trying to do SPI operations at the same
> time.

These kind of changes it requires are consuming a bit more time than
I was hoping for.

So maybe at this very moment the best is reverting the patch.

I have some patches that would move towards that goal in
baby steps without having to resort to a big rewrite at
this very moment.

Maybe Jon can check each patch one after another to see if any is 
producing the unexpected behavior and only then you would include
them...

As for the root cause of the regression: my guess is that spi-mem is
just not triggering a shutdown any more because of how message_pump works.

The improvement of the state-machine can then get addressed
separately.

Martin
