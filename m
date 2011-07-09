From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/6] Add device tree support for imx spi driver
Date: Sat, 9 Jul 2011 14:44:41 +0800
Message-ID: <20110709064440.GD13962@S2100-06.ap.freescale.net>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<20110708190142.GD9070@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110708190142.GD9070-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 08, 2011 at 01:01:42PM -0600, Grant Likely wrote:
> On Fri, Jul 08, 2011 at 04:27:28PM +0800, Shawn Guo wrote:
> > The patch set makes some cleanups on imx spi driver to get it ready
> > for adding device tree probe and then add the support.
> > 
> > Those two dt helper function related patches are carried here to
> > resolve the dependency.  They should be on the way to sit on Grant's
> > devicetree/next branch.
> > 
> > Rob Herring (1):
> >       dt: add helper function to read u32 arrays
> > 
> > Shawn Guo (5):
> >       ARM: mxc: remove unnecessary header file inclusion from gpio.h
> >       spi/imx: use soc name in spi device type naming scheme
> >       spi/imx: copy gpio number passed by platform data into driver private data
> >       dt: add empty of_property_read_u32[_array] for non-dt
> >       spi/imx: add device tree probe support
> 
> Okay, I tried to apply this series, but the first patch that removes
> the includes caused a build failure, so I've dropped it.  What tree
> are these patches based on top of?
> 
I based the series off linux-next.  Since it will go through your
spi/next tree, I will repost the series against it, with splitting
patch #2 into small pieces to address Sascha's comment.

-- 
Regards,
Shawn
