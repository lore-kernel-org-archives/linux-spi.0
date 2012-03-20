From: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Subject: RE: [PATCH v4] SPI: add CSR SiRFprimaII SPI controller driver
Date: Tue, 20 Mar 2012 08:02:57 +0000
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9CF46C749@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1329126338-23810-1-git-send-email-Barry.Song@csr.com>
	<20120309215310.30D323E0880@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	DL-SHA-WorkGroupLinux <Workgroup.Linux-kQvG35nSl+M@public.gmane.org>,
	Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120309215310.30D323E0880@localhost>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> -----Original Message-----
> From: Grant Likely [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On Behalf Of Grant Likely
> Sent: Saturday, March 10, 2012 5:53 AM
> To: Barry Song
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; DL-SHA-WorkGroupLinux; Zhiwu
> Song; Barry Song
> Subject: Re: [PATCH v4] SPI: add CSR SiRFprimaII SPI controller driver
> 
> On Mon, 13 Feb 2012 17:45:38 +0800, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
> wrote:
> > From: Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>
> >
> > CSR SiRFprimaII has two SPIs (SPI0 and SPI1). Features:
> > * Master and slave modes
> > * 8-/12-/16-/32-bit data unit
> > * 256 bytes receive data FIFO and 256 bytes transmit data FIFO
> > * Multi-unit frame
> > * Configurable SPI_EN (chip select pin) active state
> > * Configurable SPI_CLK polarity
> > * Configurable SPI_CLK phase
> > * Configurable MSB/LSB first
> >
> > Signed-off-by: Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>
> > Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> 
> Applied, thanks.
> 
> However, the spi subsystem now implements core queuing.  I'd like you
> to remove the queuing from this driver to use the code supplied by the
> core and have a patch ready for v3.5

Thanks. actually there are some changes in pinmux subsystem as well, I'll also take care that.

> 
> Thanks,
> g.

-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
