From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: linux-next: manual merge of the pxa tree
Date: Tue, 16 Sep 2008 11:02:50 +0800
Message-ID: <f17812d70809152002p6df35c05o743d9d86fca37827@mail.gmail.com>
References: <20080915052750.0b0c924c.sfr@canb.auug.org.au>
	 <48CE60A6.4000705@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Stephen Rothwell" <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	spi-devel <spi-devel-general@lists.sourceforge.net>
To: "Ned Forrester" <nforrester@whoi.edu>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <48CE60A6.4000705@whoi.edu>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 15, 2008 at 9:18 PM, Ned Forrester <nforrester@whoi.edu> wrote:
> Stephen Rothwell wrote:
>> Hi Eric,
>>
>> Today's linux-next merge of the pxa tree got a conflict in
>> drivers/spi/pxa2xx_spi.c between commit
>> 8423597d676615f3dd2d9ab36f59f147086b90b8 ("pxa2xx_spi: chipselect
>> bugfixes") from Linus' tree and commit
>> 5625ef19d54c02838c867b6a5c87823e021ac7a5 ("spi: pxa2xx_spi introduce chip
>> select gpio to simplify the common cases") from the pxa tree.
>>
>> I fixed it up (see below) and can carry the fixup (though it could be
>> fixed in the pxa tree in a merge with Linus' tree).  Please check the
>> fixup.
>
> The last word I had from David Brownell, was that Eric should make his
> patch fit after mine.  I think Eric was planning to re-submit, but maybe
> you have saved him the trouble.  I will leave it to Eric to decide if
> you fixed everything needed.
>

I'll take off the patch to save Stephen's time on this. Sorry for the
noise.

- eric
