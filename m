From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 1/4] of: adapt
	of_find_i2c_driver() to be usable by SPI also
Date: Fri, 25 Jul 2008 14:52:38 -0400
Message-ID: <fa686aa40807251152t22848f69l924b0f83f1871165@mail.gmail.com>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073311.8485.16226.stgit@trillian.secretlab.ca>
	<9e4733910807250840n48c6ae79l27af4f320b5b1df1@mail.gmail.com>
	<fa686aa40807250921v73bec21cya6b4cd494f12f2e8@mail.gmail.com>
	<9e4733910807251002w7da115e5r53600f1cf4e3891@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9e4733910807251002w7da115e5r53600f1cf4e3891-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, Jul 25, 2008 at 1:02 PM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 7/25/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Fri, Jul 25, 2008 at 11:40 AM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>  > On 7/25/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>  >>  + * First method is to lookup the compatible value in of_modalias_table.
>>  >>  + * Second is to look for a "linux,<modalias>" entry in the compatible list
>>  >>  + * and used that for modalias.  Third is to strip off the manufacturer
>>  >>  + * prefix from the first compatible entry and use the remainder as modalias
>>  >
>>  > I also think this is a problem. Embedding the name of Linux device
>>  > drivers into device firmware makes it almost impossible to rename the
>>  > device driver.  Again, what is a case where generic part numbers can't
>>  > be listed in the alias section of the linux device driver?
>>  >
>>  > Even eeprom was just fixed to take generic part numbers (at24).
>>
>> Again, I agree, but this change is very much a stop gap measure to get
>>  things working in a sane way without having to create bad device tree
>>  bindings (device tree bindings are hard to change, code is not).  I've
>>  been considering posting a patch to remove this clause from the
>>  functions, but that needs to be reviewed separately from this change.
>
> Isn't putting "compatible="linux,modalias"" into your device tree a
> really bad idea?

Yes, it is, but I still need to preserve existing behavior in this
patch.  That change needs to be reviewed separately.  I'll submit
another patch to deal with this.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
