From: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] spi: free children in spi_unregister_master, not siblings
Date: Wed, 1 Sep 2010 17:52:55 +0200
Message-ID: <20100901155255.GB2483082@jupiter.n2.diac24.net>
References: <20100830095837.GA2404529@jupiter.n2.diac24.net>
	<20100830213949.GB2413339@jupiter.n2.diac24.net>
	<20100830215417.GC2413339@jupiter.n2.diac24.net>
	<20100901152412.GC13421@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100901152412.GC13421-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 01, 2010 at 09:24:12AM -0600, Grant Likely wrote:
> On Mon, Aug 30, 2010 at 11:54:17PM +0200, David Lamparter wrote:
> > introduced by 49dce689ad4ef0fd1f970ef762168e4bd46f69a3 and bad-fixed by
> > 350d0076c5763ca2b88ca05e3889bfa7c1905f21, spi_unregister_master would
> > previously device_unregister all of the spi master's siblings (instead
> > of its children). hilarity ensues.
> 
> Obviously correct.  Applied, and I'll push it out after some testing.

Thanks!

> BTW, you should be friendly to reviewers when quoting sha1 commit
> ids.  You should also quote the patch title so that readers don't
> need to context-switch to git or the web to figure out what the
> patches actually are.  This is how I fixed it up in the commit:
> 
>   introduced by 49dce689 ("spi doesn't need class_device") and bad-fixed
>   by 350d0076 ("spi: fix double-free on spi_unregister_master"),
>   spi_unregister_master would previously device_unregister all of the spi
>   master's siblings (instead of its children). hilarity ensues.

Ah. I oriented on 350d0076's commit message ("spi: fix double-free on
spi_unregister_master") which did strike me as weird, but I didn't
think. Will remember to do better in the future.


-David


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
