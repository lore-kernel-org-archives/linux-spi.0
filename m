From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: add OpenCores tiny SPI driver
Date: Mon, 24 Jan 2011 08:50:02 -0700
Message-ID: <20110124155002.GA16370@angua.secretlab.ca>
References: <1294800109-31603-1-git-send-email-thomas@wytron.com.tw>
	<1295249542-26743-1-git-send-email-thomas@wytron.com.tw>
	<20110120165430.GA24445@angua.secretlab.ca>
	<4D38AAEB.7020308@wytron.com.tw>
	<1295612849.23825.26.camel@needafix>
	<4D3CD38D.4080808@wytron.com.tw>
	<1295866794.23825.100.camel@needafix>
	<4D3D91D1.8000701@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D3D91D1.8000701-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 24, 2011 at 10:50:57PM +0800, Thomas Chou wrote:
> Hi Jonas,
> 
> On 01/24/2011 06:59 PM, Jonas Bonn wrote:
> >We've discussed this a bit internally now and decided that the best way
> >to version OpenCores cores is to use the SVN commit ID of the rtl/
> >directory in the project's repository.  So, for your tiny-spi project,
> >the last SVN commit to update the rtl/ directory was commit number 2;
> >hence, I'd recommend you use the following device tree identifier:
> >
> >opencores,tiny-spi-rtlsvn2
> >
> >That's:  opencores,<project>-rtl<VCS><commit ID>
> >
> >As projects are currently in SVN, VCS=svn.
> >
> >Linux drivers for other OpenCores cores will be updated accordingly.
> 
> I will follow your suggestion exactly. Thank you very much.

Make sure you also document the binding in Documentation/powerpc/dts-bindings

g.
