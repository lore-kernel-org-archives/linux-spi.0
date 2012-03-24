From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH RFC] spi: spi-davinci: Fix DMA API usage in davinci
Date: Sat, 24 Mar 2012 16:59:11 +0000
Message-ID: <20120324165911.E850A3E09CC@localhost>
References: <1332240009-2011-1-git-send-email-shubhrajyoti@ti.com>
	<20120320162335.65ACD3E2834@localhost>
	<DF0F476B391FA8409C78302C7BA518B631802D1C@DBDE01.ent.ti.com>
	<CAM=Q2cvfDe8U+iReAG0N3Rv3k99BMzUoMAJWJ+8PzstZY0hZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "Datta,  Shubhrajyoti"
	<shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Nori, Sekhar"
	<nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <CAM=Q2cvfDe8U+iReAG0N3Rv3k99BMzUoMAJWJ+8PzstZY0hZYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 22 Mar 2012 21:31:03 +0530, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Sekhar,
> 
> On Thu, Mar 22, 2012 at 8:08 PM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> > Hi Grant,
> >
> > On Tue, Mar 20, 2012 at 21:53:34, Grant Likely wrote:
> >> On Tue, 20 Mar 2012 16:10:09 +0530, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> >> > The driver uses NULL for dma_unmap_single instead of
> >> > the struct device that the API expects.
> >> >
> >> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> >> > ---
> >> > I do not have the board ,untested.
> >>
> >> Can someone with this hardware please test?
> >
> > Akshay from TI tested this on DA850 EVM. He doesn't have
> > this e-mail so posting the tested-by on his behalf:
> >
> > Tested-by: Shankarmurthy, Akshay < akshay.s-l0cyMroinI0@public.gmane.org>
> 
> Thanks Akshay,

Applied, thanks.

g.
