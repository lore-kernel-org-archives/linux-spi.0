From: Steven King <sfking@fdwdc.com>
Subject: Re: [PATCH] spi: refactor spi-coldfire-qspi to use
	SPI queue framework.
Date: Fri, 11 May 2012 03:33:21 -0700
Message-ID: <201205110333.22096.sfking@fdwdc.com>
References: <201205100926.55444.sfking@fdwdc.com>
 <CAM=Q2cuxbUcXUz6iQFoYfU8xmFXvNtiVxrBAjPE9u34wNnrAbw@mail.gmail.com>
Reply-To: uClinux development list <uclinux-dev@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 uClinux development list <uclinux-dev@uclinux.org>, gerg@uclinux.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Return-path: <uclinux-dev-bounces@uclinux.org>
In-Reply-To: <CAM=Q2cuxbUcXUz6iQFoYfU8xmFXvNtiVxrBAjPE9u34wNnrAbw@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.uclinux.org/mailman/options/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=unsubscribe>
List-Archive: <http://mailman.uclinux.org/pipermail/uclinux-dev>
List-Post: <mailto:uclinux-dev@uclinux.org>
List-Help: <mailto:uclinux-dev-request@uclinux.org?subject=help>
List-Subscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=subscribe>
Errors-To: uclinux-dev-bounces@uclinux.org
Sender: uclinux-dev-bounces@uclinux.org
List-Id: linux-spi.vger.kernel.org

On Friday 11 May 2012 1:33:25 am Shubhrajyoti Datta wrote:
> Hi Steven,
>
> On Thu, May 10, 2012 at 9:56 PM, Steven King <sfking@fdwdc.com> wrote:
> > Use the new SPI queue framework; remove use of workqueue, replace
> > mcfqspi_transfer with mcfqspi_transfer_one_message, add
> > mcfqspi_prepare_transfer_hw and mcfqspi_unprepare_transfer_hw, update
> > power management routines.
>
> By update are you attempting to convert to runtime framework also?

laying the ground work for it; right now its mostly just a big nop as 
currently on Coldfire there isnt any PM support.  I suppose it would have 
been better to have that as a separate patch, i can resubmit with that broken 
out if people would prefer.
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
To unsubscribe see:
http://mailman.uclinux.org/mailman/options/uclinux-dev
