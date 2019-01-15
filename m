From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 15 Jan 2019 16:09:14 +0000
Message-ID: <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <20190115151009.GC5522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115151009.GC5522@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 15/01/2019 15:10, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 02:26:02PM +0000, Jon Hunter wrote:
> 
>> It seems that __spi_pump_messages() is getting called several times
>> during boot when registering the spi-flash, then after the spi-flash has
>> been registered, about a 1 sec later spi_pump_idle_teardown() is called
>> (as expected), but exits because 'ctlr->running' is true. However,
>> spi_pump_idle_teardown() is never called again and when we suspend we
>> are stuck in the busy/running state. In this case should something be
>> scheduling spi_pump_idle_teardown() again? Although even if it does I
>> don't see where the busy flag would be cleared in this path?
> 
> Right, I think with the current code we just shouldn't be checking for
> busy in teardown, since there's now a fairly big delay between idle and
> actually turning the hardware off the name is just super misleading and
> the logic confused.  I don't have time to test right now but does
> something like the below which changes it to a flag for the hardware
> being powered up work:

I tried your change but the same problem still persists.

Cheers
Jon

-- 
nvpublic
