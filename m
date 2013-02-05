From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH V2 2/2] spi/bcm63xx: work around inability to keep CS up
Date: Tue, 5 Feb 2013 16:00:04 +0100
Message-ID: <20130205160004.2817a8b08ba7bb8c2de9a382@openwrt.org>
References: <1359900913-4472-1-git-send-email-jogo@openwrt.org>
	<1359900913-4472-3-git-send-email-jogo@openwrt.org>
	<20130205143530.1F00D3E1265@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205143530.1F00D3E1265@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 05 Feb 2013 14:35:30 +0000
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Sun,  3 Feb 2013 15:15:13 +0100, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> > This SPI controller does not support keeping CS asserted after sending
> > a transfer.
> > Since messages expected on this SPI controller are rather short, we can
> > work around it for normal use cases by sending all transfers at once in
> > a big full duplex stream.
> > 
> > This means that we cannot change the speed between transfers if they
> > require CS to be kept asserted, but these would have been rejected
> > before anyway because of the inability of keeping CS asserted.
> > 
> > Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> 
> Are you checking the state of transfer->cs_change when merging
> transfers? If cs_change is set, then the transfers cannot be merged.

Yes, I do; I "flush" on each cs_change and after the last transfer:

> > +		if (t->cs_change ||
> > +		    list_is_last(&t->transfer_list, &m->transfers)) {
> > +			/* configure adapter for a new transfer */
> > +			bcm63xx_spi_setup_transfer(spi, first);
> >  
> > -		/* send the data */
> > -		status = bcm63xx_txrx_bufs(spi, t);
> > -		if (status)
> > -			goto exit;
> > +			/* send the data */
> > +			status = bcm63xx_txrx_bufs(spi, first, n_transfers);
> > +			if (status)
> > +				goto exit;
> > +
> > +			m->actual_length += total_len;
> >  
> > -		m->actual_length += t->len;
> > +			first = NULL;
> > +			n_transfers = 0;
> > +			total_len = 0;
> > +			can_use_prepend = false;
> > +		}
> >  	}
> >  exit:
> >  	m->status = status;
> > -- 
> > 1.7.10.4
> > 
> 
> -- 
> Grant Likely, B.Sc, P.Eng.
> Secret Lab Technologies, Ltd.

P.S: Sorry Grant for receiving this double - I can't email.

-- 
Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
