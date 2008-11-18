From: Ned Forrester <nforrester@whoi.edu>
Subject: Re: Why I dont' see spidev device entry under /dev
Date: Tue, 18 Nov 2008 13:28:10 -0500
Message-ID: <4923093A.4030400@whoi.edu>
References: <mailman.209529.1227024651.24145.gumstix-users@lists.sourceforge.net>
	<D20834BA7297D24FBF1C7894D7C3F1D801B26539@lotus.oceanasensor.ad>
Reply-To: "General mailing list for gumstix users."
	<gumstix-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "General mailing list for gumstix users."
	<gumstix-users@lists.sourceforge.net>,
	spi-devel <spi-devel-general@lists.sourceforge.net>
Return-path: <gumstix-users-bounces@lists.sourceforge.net>
In-Reply-To: <D20834BA7297D24FBF1C7894D7C3F1D801B26539@lotus.oceanasensor.ad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/gumstix-users>,
	<mailto:gumstix-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=gumstix-users>
List-Post: <mailto:gumstix-users@lists.sourceforge.net>
List-Help: <mailto:gumstix-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/gumstix-users>,
	<mailto:gumstix-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: gumstix-users-bounces@lists.sourceforge.net
List-Id: linux-spi.vger.kernel.org

Bill Cuffley wrote:
> As far as I can tell, the dev files aren't created automagically.  To do
> it manually : find out the major and minor numbers for your device
> ('dmesg' should help here, otherwise 'cat /proc/devices' should give you
> the Major number (and use 0 for minor)), and if it should be a block
> device or a character device, then use mknod to create your /dev node.
> ('man mknod' on any *nix system or google to help you here)
> 

If that does not solve the problem (try it first), you might want to ask
your question on <spi-devel-general@lists.sourceforge.net>.  There are a
number of people there that have used spidev, and even the original
author, Andrea Paterniani <a.paterniani@swapp-eng.it>, is active there.

You can subscribe to spi-devel-general at:

https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Ned Forrester                                       nforrester@whoi.edu
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
