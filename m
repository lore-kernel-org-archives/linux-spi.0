From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v2] staging: spi: mt7621: Minor code cleanup
Date: Fri, 1 Feb 2019 11:04:19 +0100
Message-ID: <20190201100419.GA17779@kroah.com>
References: <20190201085712.32380-1-sr@denx.de>
 <20190201085712.32380-2-sr@denx.de>
 <20190201090311.GA4639@kroah.com>
 <61b2570c-84c6-ccc3-2535-4197030f2cd6@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Sankalp Negi <sankalpnegi2310@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>
To: Stefan Roese <sr@denx.de>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <61b2570c-84c6-ccc3-2535-4197030f2cd6@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 01, 2019 at 10:16:23AM +0100, Stefan Roese wrote:
> On 01.02.19 10:03, Greg Kroah-Hartman wrote:
> > On Fri, Feb 01, 2019 at 09:57:12AM +0100, Stefan Roese wrote:
> > > This patch cleans up some minor issues with this driver:
> > > - Remove unnecessary header includes
> > > - Sort header alphabetically
> > > - Use correct comment style
> > > - Add return code check on device_reset()
> > > - Remove SPI_BPW_MASK definition (already available in
> > >    include/linux/spi/spi.h)
> > > - Use macros instead of hardcoded values for SPI_MASTER register access
> > >    as suggested by Neil Brown (in mt7621_spi_reset and mt7621_spi_prepare)
> > 
> > When you have to start listing the different things you do in a patch,
> > that's a huge sign you need to break this up into different patches :)
> 
> I personally find this over complex for these type of changes, that's
> why I prefer to send such "minor" changes in a single patch. But I
> can definitely split this up into multiple patches, if this is what's
> preferred by you (and others).

When you review as many patches as we do, it's _MUCH_ easier to review a
patch that only does one thing, to verify it really does that one thing
properly.  If you mix it all up, it takes a lot more effort to try to
review it all correctly.

Remember, you need to make it as easy as possible to understand the
change to make me seem horrible to reject your patch :)

thanks,

greg k-h
