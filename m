From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
Date: Tue, 15 Jan 2019 21:58:55 +0100
Message-ID: <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115192619.GG5522@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On 15.01.2019, at 20:26, Mark Brown <broonie@kernel.org> wrote:
> 
>> On Tue, Jan 15, 2019 at 06:39:27PM +0100, kernel@martin.sperl.org wrote:
>> 
>> Is it possible that the specific flash is not using the “normal” 
>> spi_pump_message, but spi_controller_mem_ops operations? 
> 
> Right, that's my best guess at the minute as well.
> 
>> Maybe we are missing the teardown in that driver or something is
>> changing flags there.
> 
>> grepping a bit:
> 
>> I see spi_mem_access_start calling spi_flush_queue, which is calling
>> pump_message, which - if there is no transfer - will trigger a delayed
>> tear-down, while it maybe should not be doing that.
> 
> If nothing else it's inefficient.
> 
>> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?
> 
> Hrm, or needs to schedule the queue at any rate (though this will only
> have an impact in the fairly unusual case where there's something
> sharing the bus with a flash).
> 
>> Unfortunately this is theoretical work and quite a lot of guesswork
>> without an actual device available for testing...
> 
> Indeed.

Maybe a bigger change to the reduce the complexity of
the state machine would solve that problem and also
reduce code complexity... 

I may find some time over the weekend if no solution
has been found until then.

The way I would envision it it would have a “state”
as a level (0=shutdown, 1=hw enabled, 2=in pump, 
3=in transfer, 4=in hw-mode,...) and a complete
to allow waking the shutdown thread (and by this
avoiding the busy wait loop we have now).
This would replace those idling, busy, and running flags.

Drawback: it is invasive, but let us see what it
really looks like...

Martin
