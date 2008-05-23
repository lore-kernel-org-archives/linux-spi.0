From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.26-rc3] spi: make
 spi_board_info.modalias a char array
Date: Fri, 23 May 2008 11:33:51 -0700
Message-ID: <20080523113351.8c16bd02.akpm@linux-foundation.org>
References: <200805211704.56761.david-b@pacbell.net>
	<20080521204633.8234c7d7.akpm@linux-foundation.org>
	<200805231031.25919.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805231031.25919.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 23 May 2008 10:31:25 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> On Wednesday 21 May 2008, Andrew Morton wrote:
> > On Wed, 21 May 2008 17:04:56 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > 
> > > From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > >		...
> > > -	proxy->modalias = chip->modalias;
> > > +	strncpy(proxy->modalias, chip->modalias, KOBJ_NAME_LEN);
> > >		...
> > 
> > a) strncpy() doesn't null-terminate the dest if it overran.  strlcpy() does.
> > 
> > b) Given the uncertainly over the state of existing code, perhaps we
> >    should have an explicit check for overflows here, with a WARN_ON()?
> > 
> > c) I think it's better to use sizeof() in the strlcpy() rather than
> >    duplicating the array size - it's a little more robust in the face
> >    of future changes and it is more obviously-correct (don't need to go
> >    elsewhere to check the size of the destination).
> 
> Good points.  I usually try to use sizeof() myself, for exactly
> that reason.  Updated version (below) uses strlcpy, sizeof, WARN_ON.

For 2.6.26?

> 
> > d) KOBJ_NAME_LEN no longer exists in linux-next.  I'm not sure where
> >    it went - Greg and Kay have been up to their usual tricks.
>  
> Yeech.  Replacing symbols with inline constants isn't good when
> the constant is what ensures various fields are the same size.
> 
> BTW -- four comments on one line is pretty good even for you.  ;)

I was quite proud of it ;)

> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> [ cope with linux-next changes: KOBJ_NAME_LEN obliterated, etc ]
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

I have a specific format for this which I never told anyone else about:

[email@address: text goes here]

Immediately before the signoffs.

If you do

	git-log | grep '^[ ]*\[akpm@' | wc -l

you'll see how many commits I have deprived myself of ;)

If we stick to that form then perhaps one day those folks who troll the
changelogs to generate who-did-what statistics can incorporate these
things.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
