From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Date: Wed, 13 Jun 2018 00:35:06 +0200
Message-ID: <20180613003506.2b521e94@bbrezillon>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180611114916.351ed272@bbrezillon>
        <87r2ldj7xi.fsf@notabene.neil.brown.name>
        <20180612092248.4e6a3e92@bbrezillon>
        <87sh5riqxx.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: NeilBrown <neil@brown.name>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh5riqxx.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 13 Jun 2018 08:24:26 +1000
NeilBrown <neil@brown.name> wrote:

> On Tue, Jun 12 2018, Boris Brezillon wrote:
> 
> >
> > Just because you managed to solve the problem in one driver does not
> > mean the problem does not exist for others. I read this datasheet [1]
> > several times and couldn't find a way to say 'I want to keep the CS
> > asserted between 2 transactions', so I think we really need this patch.  
> 
> I agree that my experience doesn't necessarily generalize.  As the patch
> carried by signed-off-by (even though I only wrote little parts of it) I
> wanted to make it clear that I had no desire to promote the patch -
> maybe I stated that too strongly.

If that's a problem, we can drop your SoB.

> 
> Thanks for the link to the data sheet.  I had a bit of a look, but
> reading these things must be an art that I haven't fully mastered yet -
> it would probably take me a few days to really understand it.
> The Programmable Sequence Enginine (Section 10.2.5.3.1) seems
> interesting. I wouldn't be surprised that that lets you do interesting
> things.

It does.

> 
> It is obviously quite a powerful unit and it is surprising - to me -
> that it might not allow arbitrarily long messages, but I cannot justify
> the time to really dig in and see if that is the case.

Unfortunately it does not allow you to manually control the CS signal,
and when it comes to data transfers you're limited by the TX/RX FIFO
size.

> Maybe you are right.  I have no particular objections to the patch, I
> just don't want to be seen as speaking in favour of it.

Okay.
