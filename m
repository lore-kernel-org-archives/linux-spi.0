From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Sat, 19 May 2012 23:26:53 -0600
Message-ID: <20120520052653.590673E03B8@localhost>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com> <4FB14B55.4070604@gmail.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>,
	Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4FB14B55.4070604@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 14 May 2012 11:13:41 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> On 05/13/2012 10:46 PM, Shubhrajyoti Datta wrote:
> > Hi David,
> > A few comments.
> >
> > On Sat, May 12, 2012 at 3:04 AM, David Daney<ddaney.cavm@gmail.com>  wrote:
> [...]
> 
> >> +
> >> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
> > This could be given a miss. As it is less meaningful once accepted.
> 
> 
> Well, this leads to the question, what is the purpose of the 
> 'MODULE_VERSION()' macro?  If I use that, I need to populate it with a 
> value.

Don't use MODULE_VERSION.  Just because it is there doesn't mean you
need to use it.  :-)  You'll notice that none of the other spi drivers
have it.

g.
