From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: spi-gpio: store chipselect information in private
	structure
Date: Wed, 25 Jul 2012 22:22:20 +0200
Message-ID: <5010557C.7090203@gmail.com>
References: <1343216652-1463-1-git-send-email-zonque@gmail.com>
	<20120725193359.GB9792@sirena.org.uk> <50104B52.7090509@gmail.com>
	<20120725195203.GC9792@sirena.org.uk> <50105052.4000603@gmail.com>
	<20120725201227.GE9792@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120725201227.GE9792-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 25.07.2012 22:12, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 10:00:18PM +0200, Daniel Mack wrote:
> 
>> I don't know what's wrong here, but clearly, the message in my inbox has
> 
>> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
>> 	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
>> 	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
>> 	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
>> And I sent them off with git "send-email --to
>> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org --cc grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org ..."
> 
>> Sorry if that's my mistake, I just don't see it.
> 
> I forwarded <1343216652-1463-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> to you
> under separate cover.
> 

Yes, you're right - I also saw that on the devicetree-discuss archives.
Still, I can't see the reason. My MTA's log states:

Jul 25 13:44:18 rambrand postfix/smtp[17884]: 84613C0081:
to=<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, relay=127.0.0.1[127.0.0.1]:10024,
delay=0.7, delays=0.35/0/0.01/0.34, dsn=2.0.0, status=sent (250 2.0.0
from MTA(smtp:[127.0.0.1]:10025): 250 2.0.0 Ok: queued as ED410C029D)
Jul 25 13:44:19 rambrand postfix/smtp[17898]: ED410C029D:
to=<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
relay=aspmx.l.google.com[173.194.78.26]:25, delay=1.3,
delays=0.06/0.19/0.5/0.57, dsn=2.0.0, status=sent (250 2.0.0 OK
1343216659 e19si24125620wec.111)

(Each queue ID matches one of the two original patches' Message-ID)

As you appearantly received the mail via spi-devel-general, is it
possible that that list dropped it? Must be.



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
