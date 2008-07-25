From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/4] of: adapt
	of_find_i2c_driver() to be usable by SPI also
Date: Fri, 25 Jul 2008 13:02:41 -0400
Message-ID: <9e4733910807251002w7da115e5r53600f1cf4e3891@mail.gmail.com>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073311.8485.16226.stgit@trillian.secretlab.ca>
	<9e4733910807250840n48c6ae79l27af4f320b5b1df1@mail.gmail.com>
	<fa686aa40807250921v73bec21cya6b4cd494f12f2e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40807250921v73bec21cya6b4cd494f12f2e8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

On 7/25/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Fri, Jul 25, 2008 at 11:40 AM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>  > On 7/25/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>  >> From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>  >>
>
> >>  + * At the moment, a single table is used for all bus types because it is
>  >>  + * assumed that the data size is small and that the compatible values
>  >>  + * should already be distinct enough to differentiate between SPI, I2C
>  >>  + * and other devices.
>  >
>  > Maybe add a section recommending to update the alias list in the linux
>  > device driver before adding entries here? This table should be a last
>  > resort. I'm not even sure this table should exist, what would be a
>  > case where we would need to make an entry here instead of fixing the
>  > device driver by adding an alias name?
>
>
> In principle I agree.  However, this patch is simply porting the i2c
>  specific code to something that can be used by both SPI and I2C.  I
>  don't want to rework the actual mechanism in this particular patch.  I
>  can submit an additional patch to change this along with reworking
>  some of the behavior that needs to be improved.
>
>
>  >>  + * First method is to lookup the compatible value in of_modalias_table.
>  >>  + * Second is to look for a "linux,<modalias>" entry in the compatible list
>  >>  + * and used that for modalias.  Third is to strip off the manufacturer
>  >>  + * prefix from the first compatible entry and use the remainder as modalias
>  >
>  > I also think this is a problem. Embedding the name of Linux device
>  > drivers into device firmware makes it almost impossible to rename the
>  > device driver.  Again, what is a case where generic part numbers can't
>  > be listed in the alias section of the linux device driver?
>  >
>  > Even eeprom was just fixed to take generic part numbers (at24).
>
>
> Again, I agree, but this change is very much a stop gap measure to get
>  things working in a sane way without having to create bad device tree
>  bindings (device tree bindings are hard to change, code is not).  I've
>  been considering posting a patch to remove this clause from the
>  functions, but that needs to be reviewed separately from this change.

Isn't putting "compatible="linux,modalias"" into your device tree a
really bad idea?

>
>  Thanks,
>
> g.
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
