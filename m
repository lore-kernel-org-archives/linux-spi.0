From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Date: Mon, 16 Mar 2020 15:34:55 +0100
Message-ID: <20200316143455.GA19141@qmqm.qmqm.pl>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
 <20200316121750.GD5010@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200316121750.GD5010@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 16, 2020 at 12:17:50PM +0000, Mark Brown wrote:
> On Sun, Mar 15, 2020 at 06:08:53PM +0100, Micha³ Miros³aw wrote:
> > Generic spi_transfer_one_message() implementation introduced in
> > commit b158935f70b9 has a bug in cs_change handling: it keeps CS
> > asserted when cs_change is set. Fix it.
> 
> >  	struct spi_transfer *xfer;
> > -	bool keep_cs = false;
> > +	bool keep_cs = true;
> >  	int ret = 0;
> >  	struct spi_statistics *statm = &ctlr->statistics;
> >  	struct spi_statistics *stats = &msg->spi->statistics;
> > @@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
> >  		if (xfer->cs_change) {
> >  			if (list_is_last(&xfer->transfer_list,
> >  					 &msg->transfers)) {
> > -				keep_cs = true;
> > +				keep_cs = false;
> >  			} else {
> 
> This is the opposite of the intended behaviour - we want to deassert
> chip select at the end of the message unless cs_change is set on the
> last transfer.  If this were broken I would expect to see widespread
> problems being reported.

This is unfortunate naming I suppose. I reread the spi.h comments
a few more times and it seems indeed, that .cs_change == 1 on last
transfer means to a driver: "you may leave CS unchanged" - quite the
reverse compared to non-last transfers.

Please drop this patch then.

Best Regards
Micha³ Miros³aw
