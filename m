From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 14:07:09 +0200
Message-ID: <20190801120709.GC31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <20190801112655.GA5488@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190801112655.GA5488@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 01, 2019 at 12:26:55PM +0100, Mark Brown wrote:
> On Thu, Aug 01, 2019 at 01:13:53PM +0200, Peter Zijlstra wrote:
> 
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> 
> I don't have a cover letter or any other context, what's going on here
> with dependencies?

Patch stands on it own. I just went through the tree looking for FIFO
(ab)users.
