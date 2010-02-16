From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/5] spi/mmc_spi: SPI bus locking to use
 mmc_spi together with other SPI devices
Date: Tue, 16 Feb 2010 20:44:50 +0100
Message-ID: <20100216204450.e043eed8.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Abstract 
--------
* SPI bus locking required for mmc_spi driver sharing
  the bus with other SPI devices.
* Proposal for API functions for SPI bus locking:
  In addition to spi_lock_bus/spi_unlock_bus, there
  will be spi_register_lock_bus/spi_unregister_lock_bus.
* Patches for spi_mpc8xxx.c for SPI bus locking.

The problem
-----------
The mmc_spi driver requires an exclusive access to the
SPI bus that must not be interrupted by accessing any 
other SPI device on the same bus. 

The current situation
---------------------
In the current kernel, the mmc_spi driver is operable
only when no other SPI clients use the same bus. At 
initialization time, it checks if it is the only SPI 
client, and refuses to install itself with a 
"can't share SPI bus" message otherwise.
If it is the only SPI client, it tells its wishes 
with an "ASSUMING SPI bus stays unshared" message; 
future SPI client registrations will not be prohibited.

Previous attempts to solve the problem
--------------------------------------
There was a set of patches by Yi Li/Bryan Wu/Mike Frysinger 
to introduce two API functions spi_lock_bus() and 
spi_unlock_bus() to enable cooperative sharing of the
SPI bus between the mmc_spi driver and other SPI drivers. 
It requires code extension in the SPI master driver to 
handle the exclusive bus access, which was implemented in
the ucLinux Blackfin SPI driver spi_bfin5xx.c.
The extended SPI master driver transmits only SPI messages
for the SPI device that locked the bus, messages for all
other SPI devices remain queued until the bus is unlocked.
The code is available in the current uClinux Blackfin tree.

Proposal for a solution
-----------------------
In addition to the previously proposed spi_lock_bus() 
and spi_unlock_bus() functions, two functions 
spi_register_lock_bus() and spi_unregister_lock_bus() 
can be implemented that can be used by a driver 
that wants to call spi_lock_bus() and spi_unlock_bus. 

A transition from the existing situation 
to a convenient solution could be:

* Insertion of spi_(un)register_lock_bus 
  and spi_(un)lock_bus calls into mmc_spi.c
* Implementation of spi_register_(un)lock_bus() 
  in spi.c.
* Implementation of spi_(un)lock_bus() in spi.c.
* Integration of the changes to spi_bfin5xx.c 
  (uClinux Blackfin tree) and to the PowerQuicc 
  spi_mpc8xxx.c driver (new patch) implementing 
  the (un)lock_bus handlers.

Implementation of the API functions
-----------------------------------
int spi_register_lock_bus()
{
    // The implementation of spi_register_lock_bus()
    // allows bus locking only for one SPI driver,
    // i.e. the mmc_spi driver.
    if (bus locking rights already 
        granted to another caller) {
        return FAILURE;
    } 
    
    if (SPI master capable of bus locking) {
        return SUCCESS;
    } 

    if (caller is the only SPI device) {
        let future spi_add_device calls fail;
        return SUCCESS;
    } 
    

    return FAILURE;
}

void spi_lock_bus()
{
    // The implementation of spi_lock_bus has no need 
    // to sleep, and it cannot fail because nobody but
    // the caller itself (mmc_spi) can hold the lock.
  
    if (SPI master capable of bus locking) {
        call SPI master lock_bus();
    }
}

Possible future extensions
--------------------------
As soon as there will be a requirement for more than
one driver obtaining an SPI bus lock, the 
spi_(un)lock_bus() functions can be extended to 
put the caller to sleep until the bus lock 
becomes available. 
The spi_register_bus_lock() function then can allow
more than one driver to register for bus locking.
The mmc_spi driver and the already modified SPI
master drivers do not need to be reworked again.

Patches
-------
The successive mails will contain these patches:
1 - spi_lock_bus (previously released patch)
2 - spi_register_lock_bus
3 - added spi_lock_bus to mmc_spi (previously released patch)
4 - added spi_register_lock_bus to mmc_spi
5 - SPI bus locking for spi_mpc8xxx.c

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
