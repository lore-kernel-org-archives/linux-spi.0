From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Thu, 16 Sep 2010 13:53:02 -0600
Message-ID: <20100916195302.GB11001@angua.secretlab.ca>
References: <1283446992-23764-1-git-send-email-wellsk40@gmail.com>
	<AANLkTi=2XQ==iCYtAQ_74wPZ6JRB3x9SjS=sjVoC5YiM@mail.gmail.com>
	<AANLkTik4Jm6u+jowgG7Py3u8N=B48opWYAikGztpXhs_@mail.gmail.com>
	<AANLkTimm1VujXp6dsQLqJt_GRmE3xOS5Z-i7wvJLj5Nc@mail.gmail.com>
	<AANLkTimySFr+QuKTPuR3xiC3Uq-xZ-E_5Bdjs_DOMbmJ@mail.gmail.com>
	<083DF309106F364B939360100EC290F80AF398DEF1@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org" <Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <083DF309106F364B939360100EC290F80AF398DEF1-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 16, 2010 at 09:49:34PM +0200, Kevin Wells wrote:
> > >> Yes - the clients and the client setup info need some changes.
> > >> I'm currently testing these patches and will post them soon.
> > >
> > > OK great, can you make this a patch series?
> > >
> > > Like
> > > 1/2 - changes to amba-pl022.c
> > > 2/2 - changes to clients
> > >
> > > or so?
> > 
> > Nah.  As mentioned on other thread.  Just squash it all into one
> > patch.  Otherwise hoops need to be jumped through to preserve
> > bisectability.
> > 
> 
> I think I missed the other thread. But simple is good and it's
> bundled as a single patch. This has Linus W's ACK.
> 
> Can you please pull it from:
> 	git://git.lpclinux.com/linux-2.6-lpc amba_pl022_spimode
> 
> The only change from the original posted series is the bit 6/7
> SPHA mode fix. The git comment has also been slightly reduced.
> If needed, I can also send out the single patch to the ml.

Please send the patch to the list.

g.


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
